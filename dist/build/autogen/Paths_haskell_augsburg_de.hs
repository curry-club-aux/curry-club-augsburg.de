module Paths_haskell_augsburg_de (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/lukas//.cabal/bin"
libdir     = "/home/lukas//.cabal/lib/x86_64-linux-ghc-7.8.4/haskell-augsburg-de-0.1.0.0"
datadir    = "/home/lukas//.cabal/share/x86_64-linux-ghc-7.8.4/haskell-augsburg-de-0.1.0.0"
libexecdir = "/home/lukas//.cabal/libexec"
sysconfdir = "/home/lukas//.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_augsburg_de_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_augsburg_de_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "haskell_augsburg_de_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_augsburg_de_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_augsburg_de_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
