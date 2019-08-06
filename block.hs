data Block = Block
  { previousHash :: String
  , nounce :: Integer }

genesis :: Block
genesis = Block
  { previousHash="0000000000000000000000000000000000000000000000000000000000000000"
  , nounce=0
}

setNounce :: Integer -> Block -> Block
setNounce n b = b { nounce=n }

instance Show Block where
  show b = concat . map (++ "\n") $
    [
      "==========================================",
      "previous hash: " ++ previousHash b,
      "nounce: " ++ (show $ nounce b),
      "=========================================="
    ]
