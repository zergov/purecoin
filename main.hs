import Data.Time.Clock.POSIX
import Purecoin.Block

getTime :: IO Integer
getTime = round `fmap` getPOSIXTime

main = do
  -- genesis block
  putStrLn $ show genesis

  -- second block
  time <- getTime
  let block = createBlock time (blockHash genesis)
  putStrLn $ show block
