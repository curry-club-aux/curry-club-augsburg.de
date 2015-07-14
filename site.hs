--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative ((<$>))
import           Control.Monad
import qualified Data.Map as M
import           Data.Maybe
import           Data.Monoid ((<>))
import           Data.Time
import           Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = do
  currDay <- localDay . utcToLocalTime mesz <$> getCurrentTime
  hakyllWith config $ do
    match "CNAME" $ do
      route   idRoute
      compile copyFileCompiler

    match "images/*" $ do
      route   idRoute
      compile copyFileCompiler

    match "files/*" $ do
      route   idRoute
      compile copyFileCompiler

    match "css/ubuntu/*" $ do
      route   idRoute
      compile copyFileCompiler
    match "css/*.css" $ do
      route   idRoute
      compile compressCssCompiler
    match "css/*.hs" $ do
      route   $ setExtension "css"
      compile $ fmap (fmap compressCss) $ getResourceString
        >>= withItemBody (unixFilter "cabal" ["exec", "runghc"])

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
        >>= loadAndApplyTemplate "templates/default.html" postCtx
        >>= relativizeUrls

    match "index.html" $ do
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll "posts/*"
        meetups <- fmap catMaybes $ forM posts $ \post -> do
          time <- getMeetupTime curryClubLocale $ itemIdentifier post
          return $ flip (,) post <$> time
        let isUpcoming = (>= currDay) . localDay . utcToLocalTime mesz
            (nextMeetupDate, nextMeetupItem) =
              last $ filter (isUpcoming . fst) meetups
        nextMeetupBody <- loadSnapshotBody (itemIdentifier nextMeetupItem) "html-post"
        let indexCtx =
              listField "posts" postCtx (return posts)
              <> constField "next-meetup-date" (formatTime curryClubLocale "%d.%m.%Y" nextMeetupDate)
              <> constField "next-meetup-body" nextMeetupBody
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

    let feedPostCount = 10
    create ["atom.xml"] $ do
      route idRoute
      compile $ do
        let feedCtx = postCtx <> constField "description" "This is the post description"
        posts <- fmap (take feedPostCount) . recentFirst =<< loadAll "posts/*"
        renderAtom feed feedCtx posts

    create ["rss.xml"] $ do
      route idRoute
      compile $ do
        let feedCtx = postCtx <> constField "description" "This is the post description"
        posts <- fmap (take feedPostCount) . recentFirst =<< loadAll "posts/*"
        renderRss feed feedCtx posts


--------------------------------------------------------------------------------
mesz :: TimeZone
mesz = TimeZone 120 True "MESZ"

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
    , knownTimeZones = [mesz]
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
