{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric  #-}

module Expression where

-- | Parser data type for programm
data Programm
    = Programm Function Programm
    | Single Function
    deriving (Show)

-- | Parser data type for functions
data Function
    = Function0 Def0
    | Function1 Def1
    | Function2 Def2
    deriving (Show)

-- | Parser data type for action sequence
data Actions
    = ADeclare Declaration Actions
    | Actions Action Actions
    | OneDeclare Declaration
    | OneAction Action
    deriving (Show)

-- | Parser data type for single action
data Action
    = AChange Change
    | AIf EIf
    | AWhile EWhile
    | AWrite Write
    | AReturn EReturn
    | ARun0 Run0
    | ARun1 Run1
    | ARun2 Run2
    deriving (Show)

-- | Parser data type for variable declaration
data Declaration
    = Declaration String String Value 
    deriving (Show)

-- | Parser data type for variable change
data Change
    = Change String Value
    deriving (Show)

-- | Parser data type for if structure
data EIf
    = EIf Value Actions Actions
    deriving (Show)

-- | Parser data type for while structure
data EWhile
    = EWhile Value Actions
    deriving (Show)

-- | Parser data type for cout
data Write
    = Write Value
    deriving (Show)

-- | Parser data type for return
data EReturn
    = EReturn Value
    deriving (Show)

-- | Parser data type for execution of 0-argument function
data Run0
    = Run0 String
    deriving (Show)

-- | Parser data type for execution of 1-argument function
data Run1
    = Run1 String Value
    deriving (Show)

-- | Parser data type for execution of 2-argument function
data Run2
    = Run2 String Value Value
    deriving (Show)

-- | Parser data type for declaration of 0-argument function
data Def0
    = Def0 String String Actions
    deriving (Show)

-- | Parser data type for declaration of 1-argument function
data Def1
    = Def1 String String String String Actions
    deriving (Show)

-- | Parser data type for declaration of 2-argument function
data Def2
    = Def2 String String String String String String Actions
    deriving (Show)

-- | Parser data type for different values
data Value
    = VF0 F0
    | VF1 F1
    | VF2 F2
    | Var String
    | Num String
    | Str String
    | Sum Value Value
    | Sub Value Value
    | Mul Value Value
    | ELess Value Value
    | EGreater Value Value
    | EEqual Value Value
    deriving (Show)

-- | Parser data type for value-type execution of 0-argument function
data F0
    = F0 String
    deriving (Show)

-- | Parser data type for value-type execution of 1-argument function
data F1
    = F1 String Value
    deriving (Show)

-- | Parser data type for value-type execution of 2-argument function
data F2
    = F2 String Value Value
    deriving (Show)