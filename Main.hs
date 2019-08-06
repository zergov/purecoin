import Data.Time.Clock.POSIX
import Purecoin.Block
import Data.List

currentTime :: IO Integer
currentTime = round <$> getPOSIXTime

newBlock :: Block -> IO Block
newBlock previous = do
  time <- currentTime
  return $ createBlock time (blockHash previous)

proof :: Block -> Integer
proof b = head $ dropWhile predicate [0..]
  where calculatedHash n = blockHash $ setNounce n b
        target = replicate (fromIntegral $ bDifficulty b) '0'
        predicate = not . isPrefixOf target . calculatedHash

solveBlock :: Block -> IO Block
solveBlock b = do
  let nounce = proof b
  return $ setNounce nounce b

main = do
  let blockchain = take 10 $ iterate ((>>= solveBlock) . (>>= newBlock)) (pure genesis)

  -- print the blockchain
  mapM (>>= print) blockchain
