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
    sym margin nil
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
    sym2 margin nil auto
  header ? do
    borderBottom solid (px 2) black
    marginBottom (px 30)
    sym2 padding (px 12) nil
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
    sym2 padding (px 12) nil
    textAlign end

  blockquote |> footer ? do
    borderTopStyle none
    marginTop nil
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
