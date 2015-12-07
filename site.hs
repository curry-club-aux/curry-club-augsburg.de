--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Monad
import           Data.Bifunctor (bimap)
import           Data.Either (partitionEithers)
import           Data.List (partition)
import qualified Data.Map as M
import           Data.Monoid ((<>))
import           Data.Time
import           Hakyll
import           Safe
import           System.Environment


--------------------------------------------------------------------------------

data Meetup a = Meetup { meetupDate :: UTCTime, meetupPost :: a } deriving Show

main :: IO ()
main = do
  currDay <- utcToLocalDay <$> getCurrentTime
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
        allArticles <- chronological =<< loadAll "posts/*"
        (meetups, posts) <- fmap partitionEithers $ forM allArticles $ \post -> do
          time <- getMeetupTime curryClubLocale $ itemIdentifier post
          return $ maybe (Right post) (\t -> Left (Meetup t <$> post)) time
        let (nextM, _lastM) =
              bimap headMay lastMay
                $ partition (\x -> utcToLocalDay (meetupDate (itemBody x)) >= currDay) meetups
            postBody p = loadSnapshotBody (itemIdentifier p) "html-post"
            meetupField item = do
              let day = meetupDate $ itemBody item
                  post = meetupPost <$> item
              body <- postBody post
              pure $ constField "next-meetup-date" (formatTime curryClubLocale "%d.%m.%Y" day)
                <> constField "timezone" (timeZoneName currentTimeZone)
                <> constField "next-meetup-body" body

        nextMField <- maybe (pure mempty) meetupField nextM
        let indexCtx =
              listField "posts" postCtx (return $ reverse posts)
              <> listField "meetups" meetupCtx (return $ reverse meetups)
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

-- this should be part of Hakyll
contramapContext :: (a -> b) -> Context b -> Context a
contramapContext f (Context g) = Context $ \s ss item -> g s ss (f <$> item)

postCtx :: Context String
postCtx =
  defaultContext
  <> constField "subtitle" ""
  <> dateFieldWith curryClubLocale "date" "%e. %B %Y"

meetupCtx :: Context (Meetup String)
meetupCtx = contramapContext meetupPost postCtx

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

utcToLocalDay :: UTCTime -> Day
utcToLocalDay = localDay . utcToLocalTime currentTimeZone
