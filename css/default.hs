{-# LANGUAGE OverloadedStrings #-}
import           Prelude hiding (div,(**))
import           Data.Monoid
import qualified Data.Text.Lazy.IO as L
import           Clay

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
  ((a # link) <> (a # visited)) ? 
    color (other "#75f")
  div # "#map" ? height (px 180)

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
      textAlign end
      ((a # link) <> (a # visited)) ? do
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
    textAlign end

  blockquote |> footer ? do
    borderTopStyle none
    marginTop (px 0)
    paddingTop (px 10)
    marginLeft (em 2)
    textAlign start

  div # "#info" ? do
    color (other "#555")
    fontSize (px 14)
    fontStyle italic

main :: IO ()
main = L.putStr $ render $ do
  importUrl "/css/ubuntu.css"
  bodyCss
  headerCss
  footerCss
