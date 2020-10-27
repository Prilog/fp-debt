module Main 
  ( main
  ) where

import Lexer (alexScanTokens)
import Parser (parseExpr)
import Expression

import TOCDSLPrinter (programmer, annotate)

main :: IO ()
main = do
  contents <- readFile "source.cpp"
  tokens <- return (alexScanTokens contents)
  case parseExpr tokens of
    Left  err  -> putStrLn err
    Right expr -> writeFile "CDSLResult.hs" $
      "module CDSLResult ( cmain, programm ) where\n\n" <>
      "import CDSL\n\n" <>
      programmer expr <> annotate expr