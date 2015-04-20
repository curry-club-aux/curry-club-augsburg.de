--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    match "CNAME" $ do
        route   idRoute
        compile copyFileCompiler

    match "images/*" $ do
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
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

--    create ["archive.html"] $ do
--        route idRoute
--        compile $ do
--            posts <- recentFirst =<< loadAll "posts/*"
--            let archiveCtx =
--                    listField "posts" postCtx (return posts) `mappend`
--                    constField "title" "Archives"            `mappend`
--                    defaultContext
--
--            makeItem ""
--                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
--                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
--                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

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
            let feedCtx = postCtx `mappend` constField "description" "This is the post description"
            posts <- fmap (take feedPostCount) . recentFirst =<< loadAll "posts/*"
            renderAtom feed feedCtx posts

    create ["rss.xml"] $ do
        route idRoute
        compile $ do
            let feedCtx = postCtx `mappend` constField "description" "This is the post description"
            posts <- fmap (take feedPostCount) . recentFirst =<< loadAll "posts/*"
            renderRss feed feedCtx posts


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

feed :: FeedConfiguration
feed = FeedConfiguration
    { feedTitle       = "Curry Club Augsburg"
    , feedDescription = "Neuigkeiten vom Curry Club Augsburg"
    , feedAuthorName  = "Curry Club Augsburg"
    , feedAuthorEmail = "post@curry-club-augsburg.de"
    , feedRoot        = "http://curry-club-augsburg.de"
    }

config :: Configuration
config = defaultConfiguration
    { deployCommand = "./deploy.sh" }
