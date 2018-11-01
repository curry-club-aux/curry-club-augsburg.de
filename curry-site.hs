{-# LANGUAGE OverloadedStrings, LambdaCase #-}

import           Control.Monad
import           Data.Bifunctor (bimap)
import           Data.Either (partitionEithers)
import           Data.Function (on)
import           Data.List (partition, sortBy)
import           Data.Maybe (isJust)
import           Data.Monoid ((<>))
import           Data.Time
import           Data.Yaml (parseMaybe, (.:), (.:?), Value)
import           Hakyll
import           Safe
import           System.Posix.Env (getEnv)


--------------------------------------------------------------------------------

data Meetup a =
  Meetup
  { meetupDay :: UTCTime
  , meetupTime :: TimeOfDay
  , meetupUpcoming :: Bool
  , meetupCounter :: Maybe Value
  , meetupPost :: a
  } deriving Show

data Backend
  = Stack
  -- ^ use the stack tool to build haskell files
  | Cabal
  -- ^ use cabal to build haskell files
  | InPath
  -- ^ assume every executable is already in PATH

readBackend :: IO (Maybe Backend)
readBackend = do
  be <- getEnv "backend"
  pure $ be >>= \case
    "stack" -> Just Stack
    "cabal" -> Just Cabal
    "inpath" -> Just InPath
    _       -> Nothing

main :: IO ()
main = do
  -- the default backend is stack; this is used for building the css
  backend <- maybe Stack id <$> readBackend
  currDay <- utcToLocalDay <$> getCurrentTime
  hakyllWith config $ do
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
      compile $ do
        fp <- toFilePath <$> getUnderlying
        css <- compressCss <$> case backend of
          Cabal -> unixFilter "cabal" ["run", "-v0", "css"] ""
          -- TODO: stack should be invoked like cabal, so that it uses the .cabal css section
          Stack -> unixFilter "stack" ["--resolver", "lts-8.17", "--install-ghc", "runghc"
                           ,"--package", "clay", "--package", "text", fp] ""
          InPath -> unixFilter "css" [] ""
        makeItem css

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
        allArticles <- chronological =<< loadAllSnapshots "posts/*" "html-post"
        (meetups, posts) <- fmap partitionEithers $ forM allArticles $ \post -> do
          maybe (Right post) Left <$> parseMeetup curryClubLocale currDay post
        let sortedMeetups = sortBy (compare `on` meetupDay . itemBody) meetups
            (upcomingMeetups, _lastM) = bimap id lastMay $ partition (meetupUpcoming . itemBody) sortedMeetups
            isRegularMeetup = isJust . meetupCounter
            nextM = headMay $ filter (isRegularMeetup . itemBody) upcomingMeetups
            meetupField item =
              let day = meetupDay $ itemBody item
                  time = meetupTime $ itemBody item
              in   constField "next-meetup-day" (formatTime curryClubLocale "%d.%m.%Y" day)
                <> constField "next-meetup-time" (formatTime curryClubLocale "%H:%M" time)
                <> constField "timezone" (timeZoneName currentTimeZone)
            nextMField = maybe mempty meetupField nextM
        let indexCtx =
              listField "posts" postCtx (return $ reverse posts)
              <> listField "upcoming-meetups" meetupCtx (return upcomingMeetups)
              <> listField "meetups" meetupCtx (return $ reverse sortedMeetups)
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

_mez :: TimeZone
_mez = TimeZone 60 True "MEZ"

currentTimeZone :: TimeZone
currentTimeZone = _mez

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

parseMeetup
  :: MonadMetadata m
  => TimeLocale
  -> Day
  -> Item a
  -> m (Maybe (Item (Meetup a)))
parseMeetup locale currDay post = do
  meta <- getMetadata (itemIdentifier post)
  pure $ do
    dayString <- parseMaybe (\o -> o .: "meetup-announcement") meta
    day <- parseTimeM True locale "%Y-%m-%d" dayString
    timeString <- parseMaybe (\o -> o .: "meetup-time") meta
    time <- parseTimeM True locale "%H:%M" timeString
    counter <- parseMaybe (\o -> o .:? "meetup-counter") meta
    pure $ flip fmap post $ \contents ->
      Meetup
      { meetupDay = day
      , meetupTime = time
      , meetupUpcoming = isUpcoming day
      , meetupCounter = counter
      , meetupPost = contents
      }
  where
    isUpcoming time = utcToLocalDay time >= currDay


-- this should be part of Hakyll
contramapContext :: (a -> b) -> Context b -> Context a
contramapContext f (Context g) = Context $ \s ss item -> g s ss (f <$> item)

postCtx :: Context String
postCtx =
  defaultContext
  <> teaserField "teaser" "html-post"
  <> dateFieldWith curryClubLocale "date" "%e. %b %y"

meetupCtx :: Context (Meetup String)
meetupCtx =
  contramapContext meetupPost postCtx
  <> boolField "meetup-upcoming" (meetupUpcoming . itemBody)
  <> field "meetup-date" (pure . formatTime curryClubLocale "%e. %b %y"
                               . meetupDay . itemBody)

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
