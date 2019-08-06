module Purecoin.Block
( Block
, genesis
, previousHash
, createBlock
, blockHash
) where

import qualified Data.ByteString
import qualified Data.ByteString.Base16 as B16
import qualified Crypto.Hash.SHA256 as SHA256

data Block = Block
  { previousHash :: String
  , timestamp :: Integer
  , nounce :: Integer }

genesis :: Block
genesis = Block
  { previousHash="0000000000000000000000000000000000000000000000000000000000000000"
  , timestamp=1565062105
  , nounce=0 }

createBlock :: Integer -> String -> Block
createBlock t prev = Block
  { previousHash=prev
  , timestamp=t
  , nounce=0 }

blockHash :: Block -> String
blockHash b = show . B16.encode $ hash
  where hash = SHA256.hash (Data.ByteString.pack [0..255])

instance Show Block where
  show b = concat . map (++ "\n") $
    [
      "=========================================="
    , "previous hash: \t" ++ previousHash b
    , "timestamp: \t" ++ (show $ timestamp b)
    , "nounce: \t" ++ (show $ nounce b)
    , "=========================================="
    ]
