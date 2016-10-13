#!/usr/bin/env stack
-- stack --resolver lts-6.20 --install-ghc runghc --package clay --package text

{-# LANGUAGE OverloadedStrings #-}

import           Prelude hiding (div,(**))
import           Data.Monoid
import qualified Data.Text.Lazy.IO as L
import           Clay
import qualified Clay.Display
import qualified Clay.Stylesheet

-- this is in the github version of clay, but not released yet
borderSpacing :: Size a -> Size a -> Css
borderSpacing v h = Clay.Stylesheet.key "border-spacing" (v ! h)

reallyDarkPurple, darkerPurple, darkPurple, ourPurple, rose :: Color
reallyDarkPurple = other "#170b1a"
darkerPurple     = other "#211024"
darkPurple       = other "#2d1630"
ourPurple        = other "#452d49"
rose             = other "#be83c6"
lightRose        = other "#DFB3E6"
almostWhite      = other "#FFFDDE"
lightYellow      = other "#FFFFB0"

bodyCss :: Css
bodyCss = body ? do
  color almostWhite
  backgroundColor darkPurple
  backgroundImages
    [ url "../images/zirbelnuss.png"
    , linearGradient (angular $ deg 180)
      [ (reallyDarkPurple, 0)
      , (darkerPurple, 5)
      , (darkPurple, 30)
      ]
    ]
  backgroundAttachment attachFixed
  backgroundRepeat noRepeat
  backgroundPosition $ placed sideRight sideBottom
  fontSize (px 15)
  lineHeight (px 24)
  fontWeight lighter
  "font-family" -: "Ubuntu, sans-serif"
  sym margin nil
  width (other "100%")

layoutCss :: Css
layoutCss = do

  ".main" |> (header <> main_ <> (footer # ".footer")) ? do
    width (px 700)
    sym2 margin nil auto
  main_ ?
    padding nil nil (px 30) nil
  article # ".important" ? do
    backgroundColor rose
    color reallyDarkPurple
    p ? do
      fontSize (px 20)
      lambdify
  article # ".bright" ? do
    backgroundColor (other "#dddddd")
    color (other "#222")
  ".main" |> header ? do
    marginTop (px 20)
    marginBottom (px 10)
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
  div # ".wrap" ?
    minHeight (other "100%")
  div # ".main" ? do
    overflow auto
    paddingBottom (px 50)
  html <> body ? height (other "100%")
  footer # ".footer" ? do
    borderTop dashed (px 1) rose
    color rose
    fontSize (px 12)
    position relative
    marginTop (px (-45))
    sym2 padding (px 10) nil
    textAlign (alignSide sideCenter)

postCss :: Css
postCss = do
  article <? do
    position relative
    "h1:first-child:first-of-type" ? lambdify
    header <? do
      h1 <? do
        marginBottom (em 0.2)
        lambdify
        lineHeight (em 2)
      div # ".info" ? do
        color rose
        fontSize (px 14)
        fontStyle italic
        marginBottom (em 1.5)
      img ? do
        maxWidth (px 400)
        display block
        sym2 margin auto auto
    img |+ (div # ".attribution") ? do
      color ourPurple
      textAlign end
      p ? sym2 margin (em 0.5) nil
      ((a # link) <> (a # visited)) ?
        color ourPurple
    ".portrait" ** img ? do
      maxWidth (em 4)
      float floatLeft
      sym margin (em 0.5)
    padding (px 10) (px 30) (px 10) (px 30)
    marginBottom (em 1)
    background reallyDarkPurple
    -- http://nicolasgallagher.com/micro-clearfix-hack/
    ":after" <> ":before" ? do
      content (stringContent " ")
      display Clay.Display.table
    ":after" ?
      clear both

syntaxCss :: Css
syntaxCss = do
  -- Colors taken from theme "Tomorrow Night"
  -- https://github.com/chriskempson/tomorrow-theme
  div # ".sourceCode" ? do
    overflowX auto
  pre # ".sourceCode" ? do
    borderLeft solid (px 2) ourPurple
    paddingLeft (px 18)
    color (other "#c5c8c6")
    ".kw" ? color (other "#de935f") -- KeyWordTok
    ".dt" ? color (other "#f0c674") -- DataTypeTok
    -- DecValTok (decimal value), BaseNTok, FloatTok
    ".dv" <> ".bn" <> ".fl" ? color (other "#D33682")
    ".ch" ? color (other "#b5bd68") -- CharTok
    ".st" ? color (other "#b5bd68") -- StringTok
    ".co" ? color (other "#b294bb") -- CommentTok
    ".ot" ? color (other "#8abeb7") -- OtherTok
    ".al" ? color (other "#cc6666") -- AlertTok
    ".fu" ? color (other "#81a2be") -- FunctionTok
    -- ErrorTok
    ".er" ? do
      fontWeight bold
      color (other "#D30102")

contentCss :: Css
contentCss = do
  star # ".clear" ?
    clear both
  h1 <> h2 <> h3 ? do
    margin (em 1) nil (em 0.5) nil
    fontWeight normal
  h1 ?
    fontSize (px 20)
  h2 ?
    fontSize (px 18)
  a ? textDecoration none
  a # hover ? textDecoration underline
  ((a # link) <> (a # visited)) ?
    color rose
  article # ".bright" ?
    ((a # link) <> (a # visited)) ?
      color ourPurple
  article # ".important" ?
    ((a # link) <> (a # visited)) ?
      color ourPurple
  p # "#next-meeting" ? do
    fontSize (px 18)
    textAlign (alignSide sideCenter)
  div # ".abstract" ?
    fontStyle italic
  address ?
    float floatLeft
  ".deemph" ? color lightRose
  ".right" ? do
    float floatRight
    paddingLeft (px 15)
    paddingBottom (px 15)
  div # "#map" ? do
    float floatRight
    height (px 220)
    width (px 400)
    border solid (px 5) ourPurple
    marginBottom (px 15)
    --sym2 margin (px 15) nil
  pre # ".error-404" ? do
    fontFamily ["Ubuntu Mono"] [monospace,sansSerif]
    fontSize (px 40)
    lineHeight (px 64)
  ul # ".post-list" ? do
    display Clay.Display.table
    borderSpacing nil (px 4)
    listStyleType none
    paddingLeft (px 0)
    li ? do
      display tableRow
      --sym2 padding (px 2) nil
    li # ".meetup-upcoming" ?
      background darkPurple
    li |> Clay.span ? do
      display tableCell
      lineHeight (px 22)
    Clay.span # ".post-date" <> Clay.span # ".meetup-date" ? do
      paddingRight (px 15)
      textAlign end
      minWidth (px 100)
    ".meetup-time" ?
      color ourPurple
    Clay.span # ".post-date" ? do
      color ourPurple
    Clay.span # ".meetup-date" ? do
      color rose
    Clay.span # ".meetup-counter" ? do
      paddingRight (px 15)
    div # ".meetup-counter-square" ? do
      display inlineBlock
      fontSize (px 24)
      lineHeight (px 40)
      backgroundColor darkPurple
      color rose
      width (px 40)
      height (px 40)
      marginBottom (px 4)
      verticalAlign textTop
      textAlign (alignSide sideCenter)
    ".meetup-upcoming" ? div # ".meetup-counter-square" ?
      background darkerPurple
    a # ".post-title" ? do
      color lightYellow
      fontSize (px 15)
    Clay.span # ".post-subtitle" ? do
      fontStyle italic
      --color lightRose
      fontSize (px 14)
  code ? do
    background ourPurple
    sym2 padding (px 1) (px 4)
    sym2 margin nil (px 4)
    fontSize (px 12)
  div # ".sourceCode" ? code ? do
    background transparent
    sym padding nil
    sym margin nil
    fontSize inherit
  a # ".yoneda-inside" ? do
    position absolute
    right (px 30)
    top (px 30)

lambdify :: Css
lambdify = before & do
  fontWeight bold
  content (stringContent "λ")
  paddingRight (px 10)
  color ourPurple

main :: IO ()
main = L.putStr $ render $ do
  importUrl "/css/ubuntu.css"
  bodyCss
  layoutCss
  contentCss
  postCss
  syntaxCss
