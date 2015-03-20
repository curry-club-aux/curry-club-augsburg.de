{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}
import           Prelude hiding (div,(**))
import qualified Prelude as P
import           Data.Monoid
import qualified Data.Text.Lazy    as L
import qualified Data.Text.Lazy.IO as L
import           Clay
import           Control.Monad
import           System.Directory

bodyCss :: Css
bodyCss = do
  body ? do
    color black
    fontSize (px 16)
    "font-family" -: "Ubuntu, sans-serif"
    margin (px 0) (px 0) (px 0) (px 0)
    width (other "100%")
    h1 ? fontSize (px 24)
    h1 ? fontSize (px 20)
  ((a # hover) <> (a # visited)) ? 
    color (other "#75f")

headerCss :: Css
headerCss = do
  (header <> main_ <> footer) ? do
    width (px 600)
    margin (px 0) auto (px 0) auto;
  header ? do
    borderBottom solid (px 2) black
    marginBottom (px 30)
    padding (px 12) (px 0) (px 12) (px 0)
    nav ? do
      textAlign (other "right")
      a ? do
        color black
        fontSize (px 18)
        fontWeight bold
        marginLeft (px 12)
        textDecoration none
  div # "#logo" ? a ? do
    color black
    float floatLeft
    fontSize (px 18)
    fontWeight bold
    textDecoration none

footerCss :: Css
footerCss = do
  footer ? do
    borderTop solid (px 2) black
    color (other "#555")
    fontSize (px 12)
    marginTop (px 30)
    padding (px 12) (px 0) (px 12) (px 0)
    textAlign (other "right")

  div # "#info" ? do
    color (other "#555")
    fontSize (px 14)
    fontStyle italic

main :: IO ()
main = do
  exD <- doesDirectoryExist "css"
  unless exD (createDirectoryIfMissing False "css")
  L.writeFile "css/default.css.tmp" $
#if 0
    renderWith compact [] $ do
#else
    render                $ do
#endif
    importUrl "/css/ubuntu.css"
    bodyCss
    headerCss
    footerCss
  copyFile "css/default.css" "css/default.css.bac"
  renameFile "css/default.css.tmp" "css/default.css"
  print "css done"
