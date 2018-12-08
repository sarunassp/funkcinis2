{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}

module Funkcinis.Types where
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
  import qualified Data.ByteString.Lazy.Char8 as B

  data BEncode1 = BEncode1
    {
      coord :: Maybe C.BList,
      prev :: Maybe BEncode1,
      result :: Maybe C.BString
    } deriving (Show)

  instance C.BEncode BEncode1 where
    toBEncode BEncode1 {..} = toDict $
            (D.pack "coord") .=? coord
        C..: (D.pack "prev") .=? prev
        C..: (D.pack "result") .=? result
        C..: endDict

    fromBEncode = fromDict $ do
        BEncode1 <$>? (D.pack "coord")
                <*>? (D.pack "prev")
                <*>? (D.pack "result")

  a = BEncode1
      {
          result = Nothing,
          coord = Just [C.toBEncode (D.pack "A"), C.toBEncode (D.pack "1")],
          prev = Nothing
      }

  parseBList :: Maybe C.BList -> [Char]
  parseBList (Just (a1:a2:rest)) = (parseString a1) ++ (parseString a2)
  parseBList Nothing = ""
  parseBList (Just []) = ""

  parseString :: BValue -> [Char]
  parseString (C.BString stringy) = D.unpack stringy

  getBList :: [[Char]] -> C.BList
  getBList (a1:rest) = getBListFromString a1
  getBList [] = []

  getBListFromString :: [Char] -> C.BList
  getBListFromString (a1:a2) = [C.toBEncode (D.pack [a1]), C.toBEncode (D.pack a2)]