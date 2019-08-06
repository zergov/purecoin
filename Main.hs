import Data.Time.Clock.POSIX
import Purecoin.Block

getTime :: IO Integer
getTime = round `fmap` getPOSIXTime

main = do
  -- genesis block
  print genesis

  -- second block
  time <- getTime
  let block = createBlock time (blockHash genesis)
  print block
