module TOCDSLPrinter
  ( annotate
  , aprog
  , afunc
  , programmer
  , functioner
  , actionsner
  , actioner
  , declarationer
  , changer
  , ifer
  , whiler
  , writer
  , returner
  , runer0
  , runer1
  , runer2
  , valuer ) where

import Expression

import Data.Char (toUpper)
import Data.List (find)

-- | Transforms C-type into Haskell-type
htype :: String -> String
htype "void" = "()"
htype (a : rest) = (toUpper a) : rest
htype _ = "!@#$%#$@"

-- | Prints t "tabs"
printTabs :: Int -> String
printTabs 0 = ""
printTabs t = "  " <> (printTabs (t - 1))

-- | Extracts string value from Var
extractIfVar :: Value -> String
extractIfVar (Var s) = s
extractIfVar _ = "!@$%@$#@"

-- | Creates annotation function, which containts all function declarations
annotate :: Programm -> String
annotate p = "programm :: CDSL r ()\nprogramm =\n" <> aprog p

-- | Creates annotation of function sequence
aprog :: Programm -> String
aprog (Single f) = afunc f
aprog (Programm f cont) = afunc f <> " >>\n" <> (aprog cont)

-- | Creates annotation of single function
afunc :: Function -> String
afunc (Function0 (Def0 _ "main" _)) = 
  "  def0 " <> show ("int main") <> " " <> "cmain"
afunc (Function0 (Def0 t n _)) = 
  "  def0 " <> show (t <> " " <> n) <> " " <> n
afunc (Function1 (Def1 t n t0 _ _)) = 
  "  def1 " <> show (t <> " " <> n) <> " " <> show t0 <> " " <> n
afunc (Function2 (Def2 t n t0 _ t1 _ _)) = 
  "  def2 " <> show (t <> " " <> n) <> " " <> 
  show t0 <> " " <> show t1 <> " " <> n

-- | Prints function sequence into haskell DSL
programmer :: Programm -> String
programmer (Single f) = functioner f
programmer (Programm f cont) = (functioner f) <> (programmer cont)

-- | Prints function into haskell DSL
functioner :: Function -> String
functioner (Function0 f) = defer0 f
functioner (Function1 f) = defer1 f
functioner (Function2 f) = defer2 f

-- | Prints 0-argument function into haskell DSL
defer0 :: Def0 -> String
defer0 (Def0 _ "main" a) =
  "cmain" <> " :: " <> "CDSL r " <> "Int" <> "\n" <> 
  "cmain" <> " =\n" <> actionsner 1 a <> "\n\n"
defer0 (Def0 t n a) =
  n <> " :: " <> "CDSL r " <> htype t <> "\n" <> 
  n <> " =\n" <> actionsner 1 a <> "\n\n"

-- | Prints 1-argument function into haskell DSL
defer1 :: Def1 -> String
defer1 (Def1 t n vt vn a) =
  n <> " :: r " <> htype vt <> " -> CDSL r " <> htype t <> "\n" <> 
  n <> " " <> vn <> " =\n" <> actionsner 1 a <> "\n\n"

-- | Prints 2-argument function into haskell DSL
defer2 :: Def2 -> String
defer2 (Def2 t n vt vn vt1 vn1 a) =
  n <> " :: r " <> htype vt <> " -> r " <> htype vt1 <> " -> CDSL r " <> 
  htype t <> "\n" <> n <> " " <> vn <> " " <> vn1 <> " =\n" <> 
  actionsner 1 a <> "\n\n"

-- | Prints action sequence into haskell DSL
actionsner :: Int -> Actions -> String
actionsner tabs (OneDeclare d) = declarationer tabs d <> printTabs tabs <> ")"
actionsner tabs (ADeclare d a) =
  declarationer tabs d <> actionsner tabs a <> ")"
actionsner tabs (OneAction a) = actioner tabs a
actionsner tabs (Actions a cont) =
  actioner tabs a <> " >>\n" <> actionsner tabs cont

-- | Prints single action into haskell DSL
actioner :: Int -> Action -> String
actioner tabs (AChange d) = changer tabs d
actioner tabs (AIf d) = ifer tabs d
actioner tabs (AWhile d) = whiler tabs d
actioner tabs (AWrite d) = writer tabs d
actioner tabs (AReturn d) = returner tabs d
actioner tabs (ARun0 d) = runer0 tabs d
actioner tabs (ARun1 d) = runer1 tabs d
actioner tabs (ARun2 d) = runer2 tabs d

-- | Prints variable declaration into haskell DSL
declarationer :: Int -> Declaration -> String
declarationer tabs (Declaration t n v) = printTabs tabs <> "v" <> t <>
  " (" <> valuer v <> ") (\\" <> n <> " -> \n"

-- | Prints variable alteration into haskell DSL
changer :: Int -> Change -> String
changer tabs (Change n v) = printTabs tabs <> n <> " =% (" <> 
  valuer v <> ")"

-- | Prints if structure into haskell DSL
ifer :: Int -> EIf -> String
ifer tabs (EIf v t f) =
  printTabs tabs <> "cif (" <> valuer v <> ") (\n" <>
  actionsner (tabs + 1) t <> "\n" <>
  printTabs tabs <> ") (\n" <>
  actionsner (tabs + 1) f <> "\n" <>
  printTabs tabs <> ")"

-- | Prints while structure into haskell DSL
whiler :: Int -> EWhile -> String
whiler tabs (EWhile v a) =
  printTabs tabs <> "cwhile (" <> valuer v <> ") (\n" <>
  actionsner (tabs + 1) a <> ")"

-- | Prints cout into haskell DSL
writer :: Int -> Write -> String
writer tabs (Write v) = printTabs tabs <> "cout (" <> valuer v <> ")"

-- | Prints return into haskell DSL
returner :: Int -> EReturn -> String
returner tabs (EReturn v) = printTabs tabs <> "creturn (" <> valuer v <> ")"

-- | Prints 0-argument function execution into haskell DSL
runer0 :: Int -> Run0 -> String
runer0 tabs (Run0 n) = printTabs tabs <> "procedure (" <> 
  "runf0 " <> show n <> " " <> n <> ")"

-- | Prints 1-argument function execution into haskell DSL
runer1 :: Int -> Run1 -> String
runer1 tabs (Run1 n a) = printTabs tabs <> "procedure (" <> 
  "runf1 " <> show n <> " (" <> n <> " (" <> valuer a <> ")))"

-- | Prints 2-argument function execution into haskell DSL
runer2 :: Int -> Run2 -> String
runer2 tabs (Run2 "getline" c v) = case valuer c of
  "get cin" -> printTabs tabs <> "getline (" <> extractIfVar v <> ")"
  _     -> "!@#$!$#%"
runer2 tabs (Run2 n a b) = printTabs tabs <> "procedure (" <> 
  "runf2 " <> show n <> 
  " (" <> n <> " (" <> valuer a <> ") (" <> valuer b <> ")))"

-- | Prints value into haskell DSL
valuer :: Value -> String
valuer (VF0 v) = fer0 v
valuer (VF1 v) = fer1 v
valuer (VF2 v) = fer2 v
valuer (Var v) = case v of
  "true"  -> "bool True"
  "false" -> "bool False"
  _       -> "get " <> v
valuer (Num v) = case find (\x -> x == '.') v of
  Just _  -> "double (" <> v <> ")"
  Nothing -> "int (" <> v <> ")"
valuer (Str v) = "string (" <> v <> ")"
valuer (Sum a b) = "(" <> valuer a <> ") +% (" <> valuer b <> ")"
valuer (Sub a b) = "(" <> valuer a <> ") -% (" <> valuer b <> ")"
valuer (Mul a b) = "(" <> valuer a <> ") *% (" <> valuer b <> ")"
valuer (ELess a b) = "(" <> valuer a <> ") <% (" <> valuer b <> ")"
valuer (EGreater a b) = "(" <> valuer a <> ") >% (" <> valuer b <> ")"
valuer (EEqual a b) = "(" <> valuer a <> ") ==% (" <> valuer b <> ")"

-- | Prints 0-argument function value into haskell DSL
fer0 :: F0 -> String
fer0 (F0 s) = "runf0 " <> show s <> " " <> s

-- | Prints 1-argument function value into haskell DSL
fer1 :: F1 -> String
fer1 (F1 s a) = "runf1 " <> show s <> " " <> s <> " (" <> valuer a <> ")"

-- | Prints 2-argument function value into haskell DSL
fer2 :: F2 -> String
fer2 (F2 s a b) = "runf2 " <> show s <> " " <> s <> 
  " (" <> valuer a <> ") (" <> valuer b <> ")"