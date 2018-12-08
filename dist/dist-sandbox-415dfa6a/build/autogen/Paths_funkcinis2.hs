{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_funkcinis2 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\bin"
libdir     = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\x86_64-windows-ghc-8.4.3\\funkcinis2-0.1.0.0-DZKipzTlqVZFCiB2B9dGi2"
dynlibdir  = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\x86_64-windows-ghc-8.4.3"
datadir    = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\x86_64-windows-ghc-8.4.3\\funkcinis2-0.1.0.0"
libexecdir = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\funkcinis2-0.1.0.0-DZKipzTlqVZFCiB2B9dGi2\\x86_64-windows-ghc-8.4.3\\funkcinis2-0.1.0.0"
sysconfdir = "C:\\Users\\Lenovo\\Source\\Repos\\funkcinis\\2 uzduotis\\haq\\.cabal-sandbox\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "funkcinis2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "funkcinis2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "funkcinis2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "funkcinis2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "funkcinis2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "funkcinis2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
