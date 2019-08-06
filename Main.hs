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
  putStrLn "------------------------------------------------------------------------------------"
  putStrLn "                                 _                   _      _            "
  putStrLn "   ||_  _ __ _  _ _ _ ___ __ ___(_)_ _    ___   __ _| |_ __| |_  __ _ ||_"
  putStrLn "  (_-< | '_ \\ || | '_/ -_) _/ _ \\ | ' \\  |___| / _` | | '_ \\ ' \\/ _` (_-<"
  putStrLn "  / _/ | .__/\\_,_|_| \\___\\__\\___/_|_||_|       \\__,_|_| .__/_||_\\__,_/ _/"
  putStrLn "   ||  |_|                                            |_|             || "
  putStrLn "------------------------------------------------------------------------------------"
  putStrLn ""
  putStrLn " the purest crypto currency you will find in  "
  putStrLn " this sick, mutable world."
  putStrLn ""
  putStrLn " So yeah, this program will just mine blocks for eternity."
  putStrLn " I am planning to mimic bitcoin as close as it is in the near future."

  -- mine block for eternity
  mapM (>>= print) . iterate ((>>= solveBlock) . (>>= newBlock)) $ (pure genesis)
