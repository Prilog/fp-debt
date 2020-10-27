{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE MultiWayIf #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module CDSL 
  ( CDSL
  , int
  , double
  , bool
  , string
  , vint
  , vdouble
  , vbool
  , vstring
  , (=%)
  , get
  , getline
  , cout
  , (>%)
  , (<%)
  , (==%)
  , (+%)
  , (-%)
  , (*%)
  , cif
  , cwhile
  , def0
  , def1
  , def2
  , creturn
  , runf0
  , runf1
  , runf2
  , procedure
  , execCDSL
  , printCDSL
  ) where

import Data.IORef
import Control.Monad (when)
import Free (Free(..), pack)

-- | Class for Int, Double and String, which support (+) operator
class Summable a where
  melt :: a -> a -> a

instance Summable Int where
  melt = (+)

instance Summable Double where
  melt = (+)

instance Summable [a] where
  melt = (++)

-- | Class for Int, Double, Bool and String, which can be converted into string
-- int, double, bool are converted as usuall
-- string is converted without quotes
class Printable a where
  myPrint :: a -> String

instance Printable Int where
  myPrint = show

instance Printable Double where
  myPrint = show

instance Printable Bool where
  myPrint = show

instance Printable [Char] where
  myPrint = id

-- | DSL action type
data Action (r :: * -> *) a where
  Number :: (Num b, Show b) => b -> (b -> next) -> Action r next 
  Boolean :: Bool -> (Bool -> next) -> Action r next
  Str :: String -> (String -> next) -> Action r next
  VInteger :: (Show b) => CDSL r Int -> (r Int -> CDSL r b) -> 
    (b -> next) -> Action r next
  VDouble :: (Show b) => CDSL r Double -> (r Double -> CDSL r b) -> 
    (b -> next) -> Action r next
  VBool :: (Show b) => CDSL r Bool -> (r Bool -> CDSL r b) -> 
    (b -> next) -> Action r next
  VStr :: (Show b) => CDSL r String -> (r String -> CDSL r b) -> 
    (b -> next) -> Action r next
  Set :: (Show a) => r a -> CDSL r a -> next -> Action r next
  Get :: (Show a) => r a -> (a -> next) -> Action r next
  Read :: r String -> next -> Action r next
  Write :: (Printable a) => CDSL r a -> next -> Action r next
  Greater :: (Ord a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  Less :: (Ord a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  Equal :: (Eq a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  Plus :: (Summable a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  Minus :: (Num a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  Multiply :: (Num a, Show a) => CDSL r a -> CDSL r a -> (a -> a -> next) -> 
    Action r next
  If :: Show a => CDSL r Bool -> CDSL r a -> CDSL r a -> (a -> next) -> 
    Action r next
  While :: Show a => CDSL r Bool -> CDSL r a -> next -> Action r next
  Function0 :: String -> CDSL r a -> next -> Action r next
  Function1 :: String -> String -> (r x -> CDSL r a) -> next -> Action r next
  Function2 :: String -> String -> String -> (r x -> r y -> CDSL r a) -> 
    next -> Action r next
  Return :: CDSL r a -> (a -> next) -> Action r next
  RunF0 :: String -> CDSL r a -> (a -> next) -> Action r next
  RunF1 :: String -> (r x -> CDSL r a) -> CDSL r x -> (a -> next) -> 
    Action r next
  RunF2 :: String -> (r x -> r y -> CDSL r a) -> CDSL r x -> CDSL r y -> 
    (a -> next) -> Action r next
  Procedure :: CDSL r a -> (a -> next) -> Action r next

deriving instance Functor (Action r)
  
-- | DSL type
type CDSL r = Free (Action r)

-- | Return CDSL Int
int :: Int -> CDSL r Int
int x = pack (Number x id)

-- | Return CDSL Double
double :: Double -> CDSL r Double
double x = pack (Number x id)

-- | Return CDSL Bool
bool :: Bool -> CDSL r Bool
bool x = pack (Boolean x id)

-- | Return CDSL String
string :: String -> CDSL r String
string s = pack (Str s id)

-- | Creates Int variable
vint :: (Show b) => CDSL r Int -> (r Int -> CDSL r b) -> CDSL r b
vint v f = pack (VInteger v f id)

-- | Creates Double variable
vdouble :: (Show b) => CDSL r Double -> (r Double -> CDSL r b) -> CDSL r b
vdouble v f = pack (VDouble v f id)

-- | Creates Bool variable
vbool :: (Show b) => CDSL r Bool -> (r Bool -> CDSL r b) -> CDSL r b
vbool v f = pack (VBool v f id)

-- | Creates String variable
vstring :: (Show b) => CDSL r String -> (r String -> CDSL r b) -> CDSL r b
vstring v f = pack (VStr v f id)

-- | Assigns new value to a variable
(=%) :: (Show a) => r a -> CDSL r a -> CDSL r ()
(=%) x v = pack (Set x v ())

-- | Extracts value from a variable
get :: (Show a) => r a -> CDSL r a
get x = pack (Get x id)

-- | Reads one line from stdin and assigns to a variable
getline :: r String -> CDSL r ()
getline var = pack (Read var ())

-- | Prints single value
cout :: (Printable a) => CDSL r a -> CDSL r ()
cout v = pack (Write v ())

-- | Returns > comparison of two numbers
(>%) :: (Ord a, Show a) => CDSL r a -> CDSL r a -> CDSL r Bool
(>%) a b = pack (Greater a b (>))

-- | Returns < comparison of two numbers
(<%) :: (Ord a, Show a) => CDSL r a -> CDSL r a -> CDSL r Bool
(<%) a b = pack (Less a b (<))

-- | Returns == comparison of two values
(==%) :: (Eq a, Show a) => CDSL r a -> CDSL r a -> CDSL r Bool
(==%) a b = pack (Equal a b (==))

-- | Returns sum of two numbers or string(OH EAH)
(+%) :: (Summable a, Show a) => CDSL r a -> CDSL r a -> CDSL r a
(+%) a b = pack (Plus a b melt)

-- | Returns substraction of two numbers
(-%) :: (Num a, Show a) => CDSL r a -> CDSL r a -> CDSL r a
(-%) a b = pack (Minus a b (-))

-- | Returns multiplication of two numbers
(*%) :: (Num a, Show a) => CDSL r a -> CDSL r a -> CDSL r a
(*%) a b = pack (Multiply a b (*))

-- | Returns if structure
cif :: (Show a) => CDSL r Bool -> CDSL r a -> CDSL r a -> CDSL r a
cif st tr fl = pack (If st tr fl id)

-- | Returns while structure
cwhile :: (Show a) => CDSL r Bool -> CDSL r a -> CDSL r ()
cwhile st ac = pack (While st ac ())

-- | Returns definition of 0-argument function
def0 :: String -> CDSL r a -> CDSL r ()
def0 name f = pack (Function0 name f ())

-- | Returns definition of 1-argument function
def1 :: String -> String -> (r x -> CDSL r a) -> CDSL r ()
def1 name t0 f = pack (Function1 name t0 f ())

-- | Returns definition of 2-argument function
def2 :: String -> String -> String -> (r x -> r y -> CDSL r a) -> CDSL r ()
def2 name t0 t1 f = pack (Function2 name t0 t1 f ())

-- | Returns return structure
creturn :: CDSL r a -> CDSL r a
creturn val = pack(Return val id)

-- | Returns running of 0-argument function
runf0 :: String -> CDSL r a -> CDSL r a
runf0 name f = pack (RunF0 name f id)

-- | Returns running of 1-argument function
runf1 :: String -> (r x -> CDSL r a) -> CDSL r x -> CDSL r a
runf1 name f x = pack (RunF1 name f x id)

-- | Returns running of 2-argument function
runf2 :: String -> (r x -> r y -> CDSL r a) -> CDSL r x -> CDSL r y -> CDSL r a
runf2 name f x y = pack (RunF2 name f x y id)

-- | Executes single action(this is return but without "return" word)
procedure :: CDSL r a -> CDSL r a
procedure val = pack(Procedure val id)

-- | Interprets CDSL into IO
execCDSL :: CDSL IORef a -> IO a
execCDSL (Pure x) = pure x
execCDSL (Free v) = case v of
  Number x next -> execCDSL $ next x
  Boolean x next -> execCDSL $ next x
  Str x next -> execCDSL $ next x
  VInteger x f next -> do
    vr <- execCDSL x >>= newIORef
    context <- execCDSL $ f vr
    execCDSL $ next context
  VDouble x f next -> do
    vr <- execCDSL x >>= newIORef
    context <- execCDSL $ f vr
    execCDSL $ next context
  VBool x f next -> do
    vr <- execCDSL x >>= newIORef
    context <- execCDSL $ f vr
    execCDSL $ next context
  VStr x f next -> do
    vr <- execCDSL x >>= newIORef
    context <- execCDSL $ f vr
    execCDSL $ next context
  Set x value next -> do
    newValue <- execCDSL value
    writeIORef x newValue
    execCDSL next
  Get x next -> do
    res <- readIORef x
    execCDSL $ next res
  Read var next -> do
    str <- getLine
    writeIORef var str
    execCDSL $ next
  Write x next -> do
    value <- execCDSL x
    putStr $ myPrint value
    execCDSL next
  Greater a b next -> execBinary a b next
  Less a b next -> execBinary a b next
  Equal a b next -> execBinary a b next
  Plus a b next -> execBinary a b next
  Minus a b next -> execBinary a b next
  Multiply a b next -> execBinary a b next
  If st tr fl next -> do
    f <- execCDSL st
    if f 
      then execCDSL tr >>= \x -> execCDSL $ next x
      else execCDSL fl >>= \x -> execCDSL $ next x
  While st ac next -> do
    iter (execCDSL st) (execCDSL ac)
    execCDSL next
      where
        iter f act = do
          saved <- f
          when saved (act >> iter f act)
  Function0 _ _ next -> do
    execCDSL $ next
  Function1 _ _ _ next -> do
    execCDSL $ next
  Function2 _ _ _ _ next -> do
    execCDSL $ next
  Return val next -> do
    value <- execCDSL val
    execCDSL $ next value
  RunF0 _ f next -> do
    result <- execCDSL f
    execCDSL $ next result
  RunF1 _ f x next -> do
    vx <- execCDSL x >>= newIORef
    result <- execCDSL (f vx)
    execCDSL $ next result
  RunF2 _ f x y next -> do
    vx <- execCDSL x >>= newIORef
    vy <- execCDSL y >>= newIORef
    result <- execCDSL (f vx vy)
    execCDSL $ next result
  Procedure val next -> do
    value <- execCDSL val
    execCDSL $ next value

-- | Interprets binary CDSL into IO
execBinary :: CDSL IORef a -> CDSL IORef b -> (a -> b -> CDSL IORef c) -> IO c
execBinary a b ev = do
  l <- execCDSL a
  r <- execCDSL b
  execCDSL $ ev l r

-- | Variable name wrapper
newtype VarID a = VarID Int

-- | Interprets CDSL into IO String(prints it...)
printCDSL :: (Show a) => CDSL VarID a -> String
printCDSL = printHelper 0 0

-- | Interprets CDSL into IO String with a tabs and variable numeration from b
printHelper :: Int -> Int -> CDSL VarID a -> String
printHelper _ _ (Pure _) = ""
printHelper tabs vars (Free c) = case c of
  Number x next -> do
    let t = printHelper tabs vars (next x)
    show x <> t
  Boolean x next -> do
    let t = printHelper tabs vars (next x)
    show x <> t
  Str x next -> do
    let t = printHelper tabs vars (next x)
    show x <> t
  VInteger x f _ -> do
    let value = printHelper tabs vars x
    let t = printHelper tabs (vars + 1) (f (VarID vars))
    printTabs tabs <> "int var" <> show vars <> " = " <> 
      value <> ";\n" <> t
  VDouble x f _ -> do
    let value = printHelper tabs vars x
    let t = printHelper tabs (vars + 1) (f (VarID vars))
    printTabs tabs <> "double var" <> show vars <> " = " <> 
      value <> ";\n" <> t
  VBool x f _ -> do
    let value = printHelper tabs vars x
    let t = printHelper tabs (vars + 1) (f (VarID vars))
    printTabs tabs <> "bool var" <> show vars <> " = " <> 
      value <> ";\n" <> t
  VStr x f _ -> do
    let value = printHelper tabs vars x
    let t = printHelper tabs (vars + 1) (f (VarID vars))
    printTabs tabs <> "string var" <> show vars <> " = " <> 
      value <> ";\n" <> t
  Set (VarID x) v next -> do
    let value = printHelper tabs vars v
    let t = printHelper tabs vars next
    printTabs tabs <> "var" <> show x <> " = " <> value <> ";\n" <> t
  Get (VarID x) _ -> "var" <> show x
  Read (VarID x) next -> do
    let t = printHelper tabs vars next
    printTabs tabs <> "getline(cin, var" <> show x <> ");\n" <> t
  Write x next -> do
    let value = printHelper tabs vars x
    let t = printHelper tabs vars next
    printTabs tabs <> "cout << " <> value <> ";\n" <> t
  Greater a b _ -> printBinary a b ">"
  Less a b _ -> printBinary a b "<"
  Equal a b _ -> printBinary a b "=="
  Plus a b _ -> printBinary a b "+"
  Minus a b _ -> printBinary a b "-"
  Multiply a b _ -> printBinary a b "*"  
  If st tr fl next -> do
    let statement = printHelper tabs vars st
    let truePart = printHelper (tabs + 1) vars tr
    let falsePart = printHelper (tabs + 1) vars fl
    let t = printHelper tabs vars $ next undefined
    printTabs tabs <> "if (" <> statement <> ") {\n" <> 
      truePart <> printTabs tabs <> "} else {\n" <> falsePart <> 
      printTabs tabs <> "}\n" <> t
  While st ac next -> do
    let statement = printHelper tabs vars st
    let body = printHelper (tabs + 1) vars ac
    let t = printHelper tabs vars next
    printTabs tabs <> "while (" <> statement <> ") {\n" <> body <> 
      printTabs tabs <> "}\n" <> t
  Function0 name f next -> do
    let body = printHelper (tabs + 1) vars f
    let t = printHelper tabs vars next
    name <> "() {\n" <> body <> "}\n" <> t
  Function1 name t0 f next -> do
    let body = printHelper (tabs + 1) (vars + 1) (f (VarID vars))
    let t = printHelper tabs vars next
    name <> "(" <> t0 <> " var" <> show vars <> ") {\n" <> body <> "}\n" <> t
  Function2 name t0 t1 f next -> do
    let fun = (f (VarID vars) (VarID (vars + 1)))
    let body = printHelper (tabs + 1) (vars + 2) fun
    let t = printHelper tabs vars next
    name <> "(" <> t0 <> " var" <> show vars <> ", " <> t1 <> " var" <> 
      show (vars + 1) <> ") {\n" <> body <> "}\n" <> t
  Return val next -> do
    let value = printHelper tabs vars val
    let t = printHelper tabs vars $ next undefined
    printTabs tabs <> "return " <> value <> ";\n" <> t
  RunF0 name _ next -> do
    let t = printHelper tabs vars $ next undefined
    name <> "()" <> t
  RunF1 name _ x next -> do
    let nx = printHelper tabs vars x
    let t = printHelper tabs vars $ next undefined
    name <> "(" <> nx <> ")" <> t
  RunF2 name _ x y next -> do
    let nx = printHelper tabs vars x
    let ny = printHelper tabs vars y
    let t = printHelper tabs vars $ next undefined
    name <> "(" <> nx <> ", " <> ny <> ")" <> t
  Procedure val next -> do
    let value = printHelper tabs vars val
    let t = printHelper tabs vars $ next undefined
    printTabs tabs <> value <> ";\n" <> t

-- | Interprets binary CDSL action into IO String with tabs and var numbers
printBinary :: (Show a, Show b) => CDSL VarID a -> CDSL VarID b -> 
  String -> String
printBinary a b s = (printCDSL a) <> " " <> s <> " " <> (printCDSL b)

-- | Prints n tabs
printTabs :: Int -> String
printTabs 0 = ""
printTabs t = "\t" <> (printTabs (t - 1))
