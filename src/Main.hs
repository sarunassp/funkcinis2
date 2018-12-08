{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RecordWildCards #-}

module Main (main) where

  import qualified Funkcinis.Main as A

  
  main :: IO [Char]
  main = A.mainA "http://battleship.haskell.lt/game/js531/player/A"
