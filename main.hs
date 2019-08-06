import Data.Time.Clock.POSIX
import Block

getTime :: IO Integer
getTime = round `fmap` getPOSIXTime

main = do
  time <- getTime

  let genesis' = genesis
  putStrLn $ show genesis

  let previous = "TODO: compute hash from genesis"
  let block = createBlock time previous
  putStrLn $ show block
