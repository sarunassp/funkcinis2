import Funkcinis.Types
import Test.Hspec
import Data.BEncode             as C
import qualified Data.ByteString.Char8 as D
 
main :: IO ()
main = hspec $ do
    describe "parseBList" $ do
        it "Empty BList returns empty string" $ do
            parseBList (Just []) `shouldBe` ""
            
        it "Nothing returns empty string" $ do
            parseBList (Nothing) `shouldBe` ""
            
        it "List of 2 strings concats them" $ do
            parseBList (Just [C.toBEncode (D.pack "A"), C.toBEncode (D.pack "1")]) `shouldBe` "A1"
            

    describe "parseString" $ do
        it "BString to [Char]" $ do
            parseString (C.toBEncode (D.pack "asd")) `shouldBe` "asd"
            

    describe "getBList" $ do
        it "Empty list returns empty BList" $ do
            getBList [] `shouldBe` []

        it "Takes first value of string list and splits it" $ do
            getBList ["A1", "A2"] `shouldBe` [C.toBEncode (D.pack "A"), C.toBEncode (D.pack "1")]
