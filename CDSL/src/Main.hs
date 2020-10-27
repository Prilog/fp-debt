module Main where

import CDSL (printCDSL, execCDSL)
import CDSLResult

main :: IO ()
main = do
  putStrLn "================="
  putStrLn "print required action:"
  putStrLn "\"exe\" - execute file CDSLResult.hs" 
  putStrLn "*filename* - interpretes CDSLResult.hs into file *filename*"
  action <- getLine
  case action of
    "exe" -> do
      result <- execCDSL cmain
      putStrLn $ "main returned with exit code: " <> show result
      return ()
    name  -> do
      let code = printCDSL programm
      writeFile name ("#include <string>\n" <>
                      "#include <cstdio>\n" <>
                      "#include <iostream>\n\n" <> 
                      "using namespace std;\n\n" <> code)
  
