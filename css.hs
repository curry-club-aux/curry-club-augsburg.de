{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}
import           Prelude hiding (div,(**))
import qualified Prelude as P
import           Data.Monoid
import qualified Data.Text.Lazy    as L
import qualified Data.Text.Lazy.IO as L
import           Clay
import           Control.Monad
-- import           System.FilePath
-- import           System.FilePath.Posix
import           System.Directory

defaultCss :: Css
defaultCss = do
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

-- Header
  (header <> main_ <> footer) ? do
    width (px 600)
    margin (px 0) auto (px 0) auto;
  header ? do
    borderBottom solid (px 2) black
    marginBottom (px 30)
    padding (px 12) (px 0) (px 12) (px 0)
    nav ? do
      "text-align" -: "right"
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

-- Footer
  footer ? do
    borderTop solid (px 2) black
    color (other "#555")
    fontSize (px 12)
    marginTop (px 30)
    padding (px 12) (px 0) (px 12) (px 0)
    "text-align" -: "right"

  div # "#info" ? do
    color (other "#555")
    fontSize (px 14)
    fontStyle italic

main :: IO ()
main = do
  ex <- doesDirectoryExist "css"
  unless ex (createDirectoryIfMissing True "css")
  -- TODO: change name
  L.writeFile "css/style.css" $
#if 0
      renderWith compact [] $ defaultCss 
#else
      render                $ defaultCss 
#endif
  print "css done"
