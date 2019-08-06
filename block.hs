module Block
( Block
, genesis
, previousHash
, createBlock
) where

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

instance Show Block where
  show b = concat . map (++ "\n") $
    [
      "=========================================="
    , "previous hash: \t" ++ previousHash b
    , "timestamp: \t" ++ (show $ timestamp b)
    , "nounce: \t" ++ (show $ nounce b)
    , "=========================================="
    ]
