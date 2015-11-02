--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Monad
import           Data.Bifunctor (bimap)
import           Data.List (partition)
import qualified Data.Map as M
import           Data.Maybe
import           Data.Monoid ((<>))
import           Data.Time
import           Hakyll
import           Safe
import           System.Environment


--------------------------------------------------------------------------------

data Meetup a = Meetup { _date :: UTCTime, _post :: Item a } deriving Show

main :: IO ()
main = do
  currDay <- localDay <$> getCurrentTime
  args <- getArgs
  let useStack = "--use-stack" `elem` args
      args'    = filter (/= "--use-stack") args
  when ("-h" `elem` args || "--help" `elem` args) $
    putStrLn "--use-stack     use 'stack exec runghc' instead of 'stack exec runghc' to compile css/default.hs\n\n"
  withArgs args' $ hakyllWith config $ do
    let idCopyFile = route idRoute >> compile copyFileCompiler

    match "CNAME" idCopyFile
    match "images/*" idCopyFile
    match "files/*" idCopyFile
    match "css/ubuntu/*" idCopyFile

    match "css/*.css" $ do
      route   idRoute
      compile compressCssCompiler

    match "css/*.hs" $ do
      route   $ setExtension "css"
      let program = if useStack then "stack" else "cabal"
      compile $ fmap (fmap compressCss) $ getResourceString
        >>= withItemBody (unixFilter program ["exec", "runghc"])

    match (fromList ["about.rst", "contact.markdown"]) $ do
      route   $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

    match "posts/*" $ do
      route $ setExtension "html"
      compile $ pandocCompiler
        >>= saveSnapshot "html-post"
        >>= loadAndApplyTemplate "templates/post.html"    postCtx
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/default.html" postCtx
        >>= relativizeUrls

    match "index.html" $ do
      route idRoute
      compile $ do
        posts <- chronological =<< loadAll "posts/*"
        meetups <- fmap catMaybes $ forM posts $ \post -> do
          time <- getMeetupTime curryClubLocale $ itemIdentifier post
          return $ flip Meetup post <$> time
        let (nextM, lastM) =
              bimap headMay lastMay
                $ partition (\x -> localDay (_date x) >= currDay) meetups
            postBody p = loadSnapshotBody (itemIdentifier p) "html-post"
            meetupField (Meetup day post) = do
              body <- postBody post
              pure $ constField "next-meetup-date" (formatTime curryClubLocale "%d.%m.%Y" day)
                <> constField "next-meetup-body" body

        nextMField <- maybe (pure mempty) meetupField nextM
        let indexCtx =
              listField "posts" postCtx (return $ reverse posts)
              <> nextMField
              <> constField "title" "Home"
              <> defaultContext

        getResourceBody
          >>= applyAsTemplate indexCtx
          >>= loadAndApplyTemplate "templates/default.html" indexCtx
          >>= relativizeUrls

    match "404.html" $ do
      route idRoute
      compile $
        getResourceBody >>= loadAndApplyTemplate "templates/default.html" defaultContext

    match "templates/*" $ compile templateCompiler
    createFeed renderAtom "atom.xml"
    createFeed renderRss  "rss.xml"

    where
      feedPostCount = 10
      createFeed kind file =
        create [file] $ do
           route idRoute
           compile $ do
               let feedCtx = postCtx `mappend` bodyField "description"
               posts <- fmap (take feedPostCount) . recentFirst =<< loadAllSnapshots "posts/*" "content"
               kind feed feedCtx posts


--------------------------------------------------------------------------------
mesz :: TimeZone
mesz = TimeZone 120 True "MESZ"

mez :: TimeZone
mez = TimeZone 60 True "MEZ"

currentTimeZone :: TimeZone
currentTimeZone = mez

curryClubLocale :: TimeLocale
curryClubLocale =
  TimeLocale
    { wDays = [ (name, take 2 name) | name <- ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"] ]
    , months = [ (name, take 3 name) | name <- ["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember"] ]
    , amPm = ("AM", "PM")
    , dateTimeFmt = "%d.%m.%Y, %H:%M"
    , dateFmt = "%d.%m.%Y"
    , timeFmt = "%H:%M"
    , time12Fmt = "%I:%M %p"
    , knownTimeZones = [currentTimeZone]
    }

getMeetupTime
  :: MonadMetadata m
  => TimeLocale
  -> Identifier
  -> m (Maybe UTCTime)
getMeetupTime locale id' = parseMeetupTime <$> getMetadata id'
  where
    parseMeetupTime metadata =
      M.lookup "meetup-announcement" metadata >>=
      parseTimeM True locale "%Y-%m-%d"

postCtx :: Context String
postCtx =
  defaultContext
  <> dateFieldWith curryClubLocale "date" "%e. %B %Y"

feed :: FeedConfiguration
feed = FeedConfiguration
  { feedTitle       = "Curry Club Augsburg"
  , feedDescription = "Neuigkeiten vom Curry Club Augsburg"
  , feedAuthorName  = "Curry Club Augsburg"
  , feedAuthorEmail = "post@curry-club-augsburg.de"
  , feedRoot        = "http://curry-club-augsburg.de"
  }

config :: Configuration
config = defaultConfiguration { deployCommand = "./deploy.sh" }

localDay :: UTCTime -> Day
localDay = localDay . utcToLocalTime currentTimeZone
