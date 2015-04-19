{-# LANGUAGE OverloadedStrings #-}
import           Prelude hiding (div,(**))
import           Data.Monoid
import qualified Data.Text.Lazy.IO as L
import           Clay

main :: IO ()
main = L.putStr $ render $ do
  importUrl "/css/ubuntu.css"
  body               ? bodyCss
  header             ? headerCss
  footer             ? footerCss
  div # "#map"       ? mapCss
  div # "#logo" |> a ? logoCss
  div # "#info"      ? infoCss
  blockquote        <? quoteCss

  (a#link <> a#visited) ? 
    color        (other "#75f")

  header <> main_ <> footer ? do
    width       $ px 600
    sym2 margin   nil auto

bodyCss :: Css
bodyCss = do
  lineHeight $ em 1.4
  color        black
  fontSize   $ px 16
  fontFamily   ["Ubuntu"] [sansSerif]
  sym margin   nil
  width      $ pct 100
  h1 <> h2 <> h3 ? margin    (em 1) nil (em 0.5) nil
  h1             ? (fontSize $ px 24)
  h2             ? (fontSize $ px 20)

mapCss :: Css
mapCss = do
    height     $ px 180
    sym margin $ px 15

headerCss :: Css
headerCss = do
  borderBottom   solid (px 2) black
  marginBottom $ px 30
  sym2 padding  (px 12) nil
  nav ? do
    textAlign        end
    a#link <> a#visited ? do
      color          black
      fontSize     $ px 18
      fontWeight     bold
      marginLeft   $ px 12
      textDecoration none

footerCss :: Css
footerCss = do
  borderTop      solid (px 2) black
  color        $ other "#555"
  fontSize     $ px 12
  marginTop    $ px 30
  sym2 padding  (px 12) nil
  textAlign      end

quoteCss :: Css
quoteCss = footer ? do
    borderTopStyle none
    marginTop      nil
    paddingTop   $ px 10
    marginLeft   $ em 2
    textAlign      start

logoCss :: Css
logoCss = do
    color          black
    float          floatLeft
    fontSize     $ px 18
    fontWeight     bold
    textDecoration none

infoCss :: Css
infoCss = do
    color     $ other "#555"
    fontSize  $ px 14
    fontStyle   italic
