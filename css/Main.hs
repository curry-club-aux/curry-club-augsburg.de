module Main where

import Data.Text.Lazy.IO as L

import CurryClub.Css (css)

main :: IO ()
main = L.putStr css
