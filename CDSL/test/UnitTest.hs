module UnitTest 
  ( printerTestTree ) where

import Test.Tasty (TestTree)
import Test.Tasty.Hspec (Spec, describe, it, shouldBe, testSpec)

import CDSL
import TestData

printerTestTree :: IO TestTree
printerTestTree = testSpec "Printer unit test" spec_printer

spec_printer :: Spec
spec_printer = do
  describe "printer is working" $ do
    describe "values" $ do
      it "int value" $
        printCDSL (int 34) `shouldBe` "34"
      it "bool value" $
        printCDSL (bool True) `shouldBe` "true"
      it "double value" $
        printCDSL (double 1.46) `shouldBe` "1.46"
      it "string value" $
        printCDSL (string "haskell") `shouldBe` "\"haskell\""
    it "return statement" $
      printCDSL (creturn (int 15)) `shouldBe` "return 15;\n"
    describe "variables + getter" $ do
      it "int variable" $
        printCDSL (vint (int 63) (\x -> creturn (get x))) 
        `shouldBe` "int var0 = 63;\nreturn var0;\n"
      it "bool variable" $
        printCDSL (vbool (bool False) (\x -> creturn (get x))) 
        `shouldBe` "bool var0 = false;\nreturn var0;\n"
      it "double variable" $
        printCDSL (vdouble (double 12.34) (\x -> creturn (get x))) 
        `shouldBe` "double var0 = 12.34;\nreturn var0;\n"
      it "string variable" $
        printCDSL (vstring (string "aaa") (\x -> creturn (get x))) 
        `shouldBe` "string var0 = \"aaa\";\nreturn var0;\n"
    describe "variables + setter" $ do
      it "int variable" $
        printCDSL (vint (int 63) (\x -> x =% (int 12))) 
        `shouldBe` "int var0 = 63;\nvar0 = 12;\n"
      it "bool variable" $
        printCDSL (vbool (bool False) (\x -> x =% (bool True))) 
        `shouldBe` "bool var0 = false;\nvar0 = true;\n"
      it "double variable" $
        printCDSL (vdouble (double 12.34) (\x -> x =% (double 44.44))) 
        `shouldBe` "double var0 = 12.34;\nvar0 = 44.44;\n"
      it "string variable" $
        printCDSL (vstring (string "aaa") (\x -> x =% (string "bbb"))) 
        `shouldBe` "string var0 = \"aaa\";\nvar0 = \"bbb\";\n"
    it "getline" $
      printCDSL (vstring (string "") (\s -> getline s))
      `shouldBe` "string var0 = \"\";\ngetline(cin, var0);\n"
    it "cout" $
      printCDSL (cout (string "!@#$%"))
      `shouldBe` "cout << \"!@#$%\";\n"
    describe "operators" $ do
      it ">" $
        printCDSL ((int 4) >% (int 5)) `shouldBe` "(4) > (5)"
      it "<" $
        printCDSL ((int 4) <% (int 5)) `shouldBe` "(4) < (5)"
      it "+" $
        printCDSL ((int 4) +% (int 5)) `shouldBe` "(4) + (5)"
      it "-" $
        printCDSL ((int 4) -% (int 5)) `shouldBe` "(4) - (5)"
      it "*" $
        printCDSL ((int 4) *% (int 5)) `shouldBe` "(4) * (5)"
      it "==" $
        printCDSL ((int 4) ==% (int 5)) `shouldBe` "(4) == (5)"
    describe "if statement" $ do
      it "simple" $ do
        printCDSL (cif (bool False) (creturn (int 5)) (creturn (int 6))) 
        `shouldBe` "if (false) {\n\treturn 5;\n} else {\n\treturn 6;\n}\n"
      it "complex" $ do
        let ifValue = ((int 5) <% ((int 6) +% (int 7)))
        let trueActions = (cout (bool True)) >> (creturn ((int 6) -% (int 4)))
        let falseActions = (cout (bool False)) >> (creturn ((int 6) +% (int 4)))
        printCDSL (cif ifValue trueActions falseActions)
        `shouldBe` "if ((5) < ((6) + (7))) " <> 
          "{\n\tcout << true;\n\treturn (6) - (4);\n} else " <> 
          "{\n\tcout << false;\n\treturn (6) + (4);\n}\n"
    describe "while statement" $ do
      it "simple" $ do
        printCDSL (cwhile (bool False) (cout (int 6))) 
        `shouldBe` "while (false) {\n\tcout << 6;\n}\n"
      it "complex" $ do
        let whileValue = ((int 5) <% ((int 6) +% (int 7)))
        let actions = (cout (bool True)) >> (cout ((int 6) -% (int 4)))
        printCDSL (cwhile whileValue actions)
        `shouldBe` "while ((5) < ((6) + (7))) " <> 
          "{\n\tcout << true;\n\tcout << (6) - (4);\n}\n"
    describe "functions" $ do
      describe "definitions" $ do
        it "0 args" $
          printCDSL (def0 "void hello" hello) 
          `shouldBe` "void hello() {\n\tcout << \"hello\";\n}\n"
        it "1 args" $
          printCDSL (def1 "void helloKitty" "string" helloKitty) 
          `shouldBe` "void helloKitty(string var0) " <>
            "{\n\tcout << (\"hello\") + (var0);\n}\n"
        it "2 args" $
          printCDSL (def2 "int csum" "int" "int" csum) 
          `shouldBe` "int csum(int var0, int var1) " <>
            "{\n\treturn (var0) + (var1);\n}\n"
      describe "calls" $ do
        it "0 args" $
          printCDSL (runf0 "hello" hello) 
          `shouldBe` "hello()"
        it "1 args" $
          printCDSL (runf1 "helloKitty" helloKitty (string "alexa")) 
          `shouldBe` "helloKitty(\"alexa\")"
        it "2 args" $
          printCDSL (runf2 "csum" csum (int 1) (int 2)) 
          `shouldBe` "csum(1, 2)"
      describe "procedures" $ do
        it "0 args" $
          printCDSL (procedure (runf0 "hello" hello))
          `shouldBe` "hello();\n"
        it "1 args" $
          printCDSL (procedure (runf1 "helloKitty" helloKitty (string "alexa"))) 
          `shouldBe` "helloKitty(\"alexa\");\n"
        it "2 args" $
          printCDSL (procedure (runf2 "csum" csum (int 1) (int 2))) 
          `shouldBe` "csum(1, 2);\n"
