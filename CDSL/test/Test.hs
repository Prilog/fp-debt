module Main where

import UnitTest (printerTestTree)
import Test.Tasty (defaultMain, testGroup)

main :: IO ()
main = do
  printerTest <- printerTestTree
  let tests = testGroup "CDSL" [printerTest]
  defaultMain tests