{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE RecordWildCards #-}

module Funkcinis.HttpHelpers where

  import Network.Wreq
  import qualified Control.Exception as E
  import Control.Lens
  import Data.Aeson.Lens (_String, key)
  import Data.BEncode             as C
  import Data.BEncode.Internal    as C
  import Data.BEncode.Types       as C
  import qualified Data.ByteString.Char8 as D
  import Network.HTTP.Client
  import qualified Data.ByteString.Lazy.Char8 as B
  import Funkcinis.Types

  urlThing :: [Char]
  urlThing = "http://battleship.haskell.lt/game/js531/player/B"

  getOpts = defaults & header "Accept" .~ ["application/bencoding"]
  postOpts = defaults & header "Content-Type" .~ ["application/bencoding"]

  doSafeGet :: [Char] -> IO (Response B.ByteString)
  doSafeGet url = (getWith getOpts url) `E.catch` handler
    where
      handler :: HttpException -> IO (Response B.ByteString)
      handler _ = do
        doSafeGet url

  getStuff :: [Char] -> IO BEncode1
  getStuff url = do
    r <- doSafeGet url
    let Right a = C.decode (D.pack (B.unpack (r ^. Network.Wreq.responseBody)))
    return a

  postStuff :: [Char] -> B.ByteString -> IO [Char]
  postStuff url bencodeData = do
    r <- postWith postOpts url bencodeData
    return ""