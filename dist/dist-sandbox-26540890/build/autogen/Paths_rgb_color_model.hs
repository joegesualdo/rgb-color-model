{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_rgb_color_model (
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

bindir     = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/bin"
libdir     = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/lib/x86_64-osx-ghc-8.2.1/rgb-color-model-0.1.0.0-2olTCxd9gMJA44RAeydlIg"
dynlibdir  = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/lib/x86_64-osx-ghc-8.2.1"
datadir    = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/share/x86_64-osx-ghc-8.2.1/rgb-color-model-0.1.0.0"
libexecdir = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/libexec/x86_64-osx-ghc-8.2.1/rgb-color-model-0.1.0.0"
sysconfdir = "/Users/jgesualdo/code/haskell/rgb-color-model/.cabal-sandbox/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "rgb_color_model_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "rgb_color_model_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "rgb_color_model_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "rgb_color_model_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "rgb_color_model_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "rgb_color_model_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
