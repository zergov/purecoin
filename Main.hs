import Data.Time.Clock.POSIX
import Purecoin.Block

currentTime :: IO Integer
currentTime = round <$> getPOSIXTime

newBlock :: Block -> IO Block
newBlock previous = do
  time <- currentTime
  return $ createBlock time (blockHash previous)

main = do
  let blockchain = take 10 $ iterate (>>= newBlock) (pure genesis)

  -- print the blockchain
  mapM (>>= print) blockchain
