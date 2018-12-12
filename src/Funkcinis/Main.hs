{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RecordWildCards #-}

module Funkcinis.Main (mainA, mainB) where

  import Network.Wreq
  import qualified Network.HTTP.Client as H
  import qualified Control.Exception as E
  import Control.Lens
  import Data.Aeson.Lens (_String, key)
  import Data.BEncode             as C
  import Data.BEncode.Internal    as C
  import Data.BEncode.Types       as C
  import qualified Data.ByteString.Char8 as D
  import Data.Bool
  import Data.List
  import Data.Char
  import Data.Bool
  import Data.Maybe
  import Network.HTTP.Client
  import Control.Concurrent
  import qualified Data.ByteString.Lazy.Char8 as B
  import Funkcinis.Types
  import Funkcinis.HttpHelpers

  needToHit1 = ["A1","B1","C1","D1","E1","F1","G1","H1","I1","J1","A2","B2","C2","D2","F2","E2","G2","H2","I2","J2","A3","B3","C3","D3","E3","F3","G3","H3","I3","J3","A4","B4","C4","D4","E4","F4","G4","H4","I4","J4","A5","B5","C5","D5","E5","F5","G5","H5","I5","J5","A6","B6","C6","D6","E6","F6","G6","H6","I6","J6","A7","B7","C7","D7","E7","F7","G7","H7","I7","J7","A8","B8","C8","D8","E8","F8","G8","H8","I8","J8","A9","B9","C9","D9","E9","F9","G9","H9","I9","J9","A10","B10","C10","D10","E10","F10","G10","H10","I10","J10"]
  myShips1 = ["A1", "B1", "C1", "B2", "B3", "A8", "A9", "A10", "B9", "C9", "F4", "G4", "H4", "G5", "G6", "H1", "I1", "J1", "I2", "I3", "H9", "I9", "J9", "J8", "J10"]

  mainA :: [Char] -> IO [Char]
  mainA url = do
    let newBencode = BEncode1 {
      result = Nothing,
      prev = Nothing,
      coord = Just (getBList needToHit1)
    }
    let newNeedToHit = removeFirstItem needToHit1
    postStuff url (encode (toBEncode newBencode))
    doStuff url myShips1 newNeedToHit

  mainB :: [Char] -> IO [Char]
  mainB url = doStuff url myShips1 needToHit1

  doStuff :: [Char] -> [[Char]] -> [[Char]] -> IO [Char]
  doStuff url myShips needToHit = do
    let getted = getStuff url
    g <- getted
    let (newBencode, newMyShips, newNeedToHit, endGame) = doCheck g myShips needToHit
    let whyHaskell = if endGame
                      then return ("i won" :: [Char])
                      else postStuff url (encode (toBEncode newBencode))
    whyHaskell2 <- whyHaskell
    if (length whyHaskell2 == 5)
      then return ("i won" :: [Char])
      else if (length newMyShips) == 0
            then return ("i lost" :: [Char])
            else doStuff url newMyShips newNeedToHit

  doCheck :: BEncode1 -> [[Char]] -> [[Char]] -> (BEncode1, [[Char]], [[Char]], Bool)
  doCheck bencode myShips needToHit = do
    let coordinate = parseBList (coord bencode)
    let result1 = if (elem coordinate myShips) then "HIT" else "MISS"
    let newMyShips = Data.List.delete coordinate myShips
    let newBencode = BEncode1 {
      result = Just (D.pack result1),
      prev = Just bencode,
      coord = if (length newMyShips == 0) then Just (getBList []) else Just (getBList needToHit)
    }
    let newNeedToHit = removeFirstItem needToHit
    let endGame = if (length coordinate == 0) then True else False
    (newBencode, (if (result1 == "HIT") then (newMyShips) else myShips), newNeedToHit, endGame)
  
  removeFirstItem :: [a] -> [a]
  removeFirstItem (a1:rest) = rest