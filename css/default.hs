{-# LANGUAGE OverloadedStrings #-}
import           Prelude hiding (div,(**))
import           Data.Monoid
import qualified Data.Text.Lazy.IO as L
import           Clay

reallyDarkPurple, darkerPurple, darkPurple, ourPurple, rose :: Color
reallyDarkPurple = other "#1e1420"
darkerPurple = other "#211024"
darkPurple = other "#2d1630"
ourPurple = other "#452d49"
rose = other "#be83c6"

bodyCss :: Css
bodyCss = do
  body ? do
    color white
    backgroundColor darkPurple
    background $ linearGradient (angular $ deg 180)
      [ (reallyDarkPurple, 0)
      , (darkerPurple, 5)
      , (darkPurple, 30)
      ]
    --backgroundRepeat noRepeat
    backgroundAttachment attachFixed
    fontSize (px 15)
    lineHeight (px 24)
    fontWeight lighter
    "font-family" -: "Ubuntu, sans-serif"
    sym margin nil
    width (other "100%")

layoutCss :: Css
layoutCss = do
  (header <> main_ <> (footer # ".footer")) ? do
    width (px 600)
    sym2 margin nil auto
  header ? do
    marginTop (px 10)
    marginBottom (px 30)
    sym2 padding (px 12) nil
    position relative
    div # "#logo" ? do
      width (px 320)
      float floatLeft
    blockquote ? do
      sym margin nil
      paddingRight (px 40)
      textAlign end
      width (px 150)
      float floatRight
      p ? sym margin nil
      footer ? do
        color rose
        borderTopStyle none
        marginTop nil
        paddingTop (px 6)
        marginLeft (em 2)
  -- based on http://www.cssstickyfooter.com
  div # ".wrap" ? do
    minHeight (other "100%")
  div # ".main" ? do
    overflow auto
    paddingBottom (px 60)
  html <> body ? height (other "100%")
  footer # ".footer" ? do
    borderTop dashed (px 1) rose
    color rose
    fontSize (px 12)
    position relative
    marginTop (px (-45))
    sym2 padding (px 10) nil
    textAlign end

contentCss :: Css
contentCss = do
  div # ".clear" ? do
    clear both
  h1 <> h2 <> h3 ? do
    margin (em 1) nil (em 0.5) nil
    fontWeight normal
  --h1 ? fontSize (px 24)
  h2 ? do
    fontSize (px 20)
  "h2:before" ? do
    fontWeight bold
    content (stringContent "λ")
    paddingRight (px 10)
    color ourPurple
  ((a # link) <> (a # visited)) ?
    color rose
  p # "#next-meeting" ? do
    fontSize (px 18)
    textAlign (alignSide sideCenter)
  address ?
    float floatLeft
  div # "#map" ? do
    float floatRight
    height (px 220)
    width (px 400)
    border solid (px 5) ourPurple
    --sym2 margin (px 15) nil
  div # "#info" ? do
    color (other "#555")
    fontSize (px 14)
    fontStyle italic
main :: IO ()
main = L.putStr $ render $ do
  importUrl "/css/ubuntu.css"
  bodyCss
  layoutCss
  contentCss
