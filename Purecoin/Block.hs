module Purecoin.Block
( Block
, genesis
, createBlock
, blockHash
, bPreviousHash
) where

import Data.Binary (encode)
import qualified Data.ByteString as BS
import Data.ByteString.Lazy (toStrict)
import qualified Data.ByteString.Base16 as B16
import qualified Crypto.Hash.SHA256 as SHA256

data Block = Block
  { bPreviousHash :: String
  , bTimestamp :: Integer
  , bNounce :: Integer
  , bDifficulty :: Integer }

genesis :: Block
genesis = Block
  { bPreviousHash="0000000000000000000000000000000000000000000000000000000000000000"
  , bTimestamp=1565062105
  , bNounce=0
  , bDifficulty=4}

createBlock :: Integer -> String -> Block
createBlock t prev = Block
  { bPreviousHash=prev
  , bTimestamp=t
  , bNounce=0
  , bDifficulty=4}

blockHash :: Block -> String
blockHash b = show . B16.encode . SHA256.hash $ header
  where header = BS.concat . map toStrict $ [previous, timestamp, nounce, difficulty]
        previous = encode $ bPreviousHash b
        timestamp = encode $ bTimestamp b
        nounce = encode $ bNounce b
        difficulty = encode $ bDifficulty b

instance Show Block where
  show b = unlines
    [
      "=========================================="
    , "hash: \t\t" ++ blockHash b
    , "previous hash: \t" ++ bPreviousHash b
    , "timestamp: \t" ++ show (bTimestamp b)
    , "nounce: \t" ++ show (bNounce b)
    , "difficulty: \t" ++ show (bDifficulty b)
    , "=========================================="
    ]
