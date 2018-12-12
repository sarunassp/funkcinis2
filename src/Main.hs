{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RecordWildCards #-}

module Main (main) where

  import qualified Funkcinis.Main as A

  
  main :: IO [Char]
  main = A.mainA "http://battleship.haskell.lt/game/testinskis00500ccaac/player/A"
