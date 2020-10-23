{-# OPTIONS_GHC -w #-}
module Parser where

import Lexer
import Expression
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Programm)
	| HappyAbsSyn5 (Function)
	| HappyAbsSyn6 (Actions)
	| HappyAbsSyn7 (Action)
	| HappyAbsSyn8 (Declaration)
	| HappyAbsSyn9 (Change)
	| HappyAbsSyn10 (EIf)
	| HappyAbsSyn11 (EWhile)
	| HappyAbsSyn12 (Def0)
	| HappyAbsSyn13 (Def1)
	| HappyAbsSyn14 (Def2)
	| HappyAbsSyn15 (Write)
	| HappyAbsSyn16 (EReturn)
	| HappyAbsSyn17 (Run0)
	| HappyAbsSyn18 (Run1)
	| HappyAbsSyn19 (Run2)
	| HappyAbsSyn20 (Value)
	| HappyAbsSyn21 (F0)
	| HappyAbsSyn22 (F1)
	| HappyAbsSyn23 (F2)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111 :: () => Int -> ({-HappyReduction (Either String) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Either String) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45 :: () => ({-HappyReduction (Either String) = -}
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Either String) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Either String) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,343) ([0,128,0,0,32,0,0,8,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,128,0,0,0,0,0,64,0,0,34,0,32768,0,0,0,0,2,2048,27648,0,10240,0,0,128,0,0,0,512,0,0,256,0,2,27,32768,49152,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,17,0,16384,0,0,4096,0,0,1408,32,0,0,4,0,88,2,0,16064,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,352,8,0,0,0,0,32790,0,32768,8197,0,0,16,0,55296,512,0,5632,128,0,0,0,0,0,0,0,0,0,0,2,27,32768,0,0,0,2,0,0,0,1,49152,62,0,43520,15,0,1024,0,0,88,2,0,16032,0,0,4008,0,0,1002,0,55296,512,0,0,0,0,1408,32,0,352,8,0,88,2,0,32790,0,32768,8197,0,24576,2049,0,0,251,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40960,250,0,0,0,0,0,0,0,0,512,0,0,128,0,16064,0,0,0,0,24576,2049,0,0,1,0,0,0,0,0,0,0,0,512,0,8,108,0,0,0,0,4008,0,0,0,0,2048,27648,0,512,6912,0,1408,32,0,0,0,0,64128,0,0,0,64,0,0,16,0,4,0,0,0,1,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,8,8192,45056,1,0,0,1,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parseExpr","Programm","Function","Actions","Action","Declaration","Change","If","While","Def0","Def1","Def2","Write","Return","ProcedureRun0","ProcedureRun1","ProcedureRun2","Value","Function0","Function1","Function2","VAR","NUM","','","'('","')'","';'","EQUAL","'='","'+'","'-'","'*'","'<'","'>'","LESSLESS","STR","IF","WHILE","ELSE","RETURN","PRINT","START","END","%eof"]
        bit_start = st * 46
        bit_end = (st + 1) * 46
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..45]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (24) = happyShift action_6
action_0 (4) = happyGoto action_7
action_0 (5) = happyGoto action_8
action_0 (12) = happyGoto action_3
action_0 (13) = happyGoto action_4
action_0 (14) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (24) = happyShift action_6
action_1 (5) = happyGoto action_2
action_1 (12) = happyGoto action_3
action_1 (13) = happyGoto action_4
action_1 (14) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (24) = happyShift action_6
action_2 (4) = happyGoto action_9
action_2 (5) = happyGoto action_8
action_2 (12) = happyGoto action_3
action_2 (13) = happyGoto action_4
action_2 (14) = happyGoto action_5
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_3

action_4 _ = happyReduce_4

action_5 _ = happyReduce_5

action_6 (24) = happyShift action_10
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (46) = happyAccept
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (24) = happyShift action_6
action_8 (4) = happyGoto action_9
action_8 (5) = happyGoto action_8
action_8 (12) = happyGoto action_3
action_8 (13) = happyGoto action_4
action_8 (14) = happyGoto action_5
action_8 _ = happyReduce_2

action_9 _ = happyReduce_1

action_10 (27) = happyShift action_11
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (24) = happyShift action_12
action_11 (28) = happyShift action_13
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (24) = happyShift action_15
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (44) = happyShift action_14
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (24) = happyShift action_29
action_14 (39) = happyShift action_30
action_14 (40) = happyShift action_31
action_14 (42) = happyShift action_32
action_14 (43) = happyShift action_33
action_14 (6) = happyGoto action_18
action_14 (7) = happyGoto action_19
action_14 (8) = happyGoto action_20
action_14 (9) = happyGoto action_21
action_14 (10) = happyGoto action_22
action_14 (11) = happyGoto action_23
action_14 (15) = happyGoto action_24
action_14 (16) = happyGoto action_25
action_14 (17) = happyGoto action_26
action_14 (18) = happyGoto action_27
action_14 (19) = happyGoto action_28
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (26) = happyShift action_16
action_15 (28) = happyShift action_17
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (24) = happyShift action_52
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (44) = happyShift action_51
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (45) = happyShift action_50
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (24) = happyShift action_29
action_19 (39) = happyShift action_30
action_19 (40) = happyShift action_31
action_19 (42) = happyShift action_32
action_19 (43) = happyShift action_33
action_19 (6) = happyGoto action_49
action_19 (7) = happyGoto action_19
action_19 (8) = happyGoto action_20
action_19 (9) = happyGoto action_21
action_19 (10) = happyGoto action_22
action_19 (11) = happyGoto action_23
action_19 (15) = happyGoto action_24
action_19 (16) = happyGoto action_25
action_19 (17) = happyGoto action_26
action_19 (18) = happyGoto action_27
action_19 (19) = happyGoto action_28
action_19 _ = happyReduce_9

action_20 (24) = happyShift action_29
action_20 (39) = happyShift action_30
action_20 (40) = happyShift action_31
action_20 (42) = happyShift action_32
action_20 (43) = happyShift action_33
action_20 (6) = happyGoto action_48
action_20 (7) = happyGoto action_19
action_20 (8) = happyGoto action_20
action_20 (9) = happyGoto action_21
action_20 (10) = happyGoto action_22
action_20 (11) = happyGoto action_23
action_20 (15) = happyGoto action_24
action_20 (16) = happyGoto action_25
action_20 (17) = happyGoto action_26
action_20 (18) = happyGoto action_27
action_20 (19) = happyGoto action_28
action_20 _ = happyReduce_8

action_21 _ = happyReduce_10

action_22 _ = happyReduce_11

action_23 _ = happyReduce_12

action_24 _ = happyReduce_13

action_25 _ = happyReduce_14

action_26 _ = happyReduce_15

action_27 _ = happyReduce_16

action_28 _ = happyReduce_17

action_29 (24) = happyShift action_45
action_29 (27) = happyShift action_46
action_29 (31) = happyShift action_47
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (27) = happyShift action_44
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (27) = happyShift action_43
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (24) = happyShift action_39
action_32 (25) = happyShift action_40
action_32 (27) = happyShift action_41
action_32 (38) = happyShift action_42
action_32 (20) = happyGoto action_35
action_32 (21) = happyGoto action_36
action_32 (22) = happyGoto action_37
action_32 (23) = happyGoto action_38
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (37) = happyShift action_34
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (24) = happyShift action_39
action_34 (25) = happyShift action_40
action_34 (27) = happyShift action_41
action_34 (38) = happyShift action_42
action_34 (20) = happyGoto action_70
action_34 (21) = happyGoto action_36
action_34 (22) = happyGoto action_37
action_34 (23) = happyGoto action_38
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (29) = happyShift action_63
action_35 (30) = happyShift action_64
action_35 (32) = happyShift action_65
action_35 (33) = happyShift action_66
action_35 (34) = happyShift action_67
action_35 (35) = happyShift action_68
action_35 (36) = happyShift action_69
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_30

action_37 _ = happyReduce_31

action_38 _ = happyReduce_32

action_39 (27) = happyShift action_62
action_39 _ = happyReduce_33

action_40 _ = happyReduce_34

action_41 (24) = happyShift action_39
action_41 (25) = happyShift action_40
action_41 (27) = happyShift action_41
action_41 (38) = happyShift action_42
action_41 (20) = happyGoto action_61
action_41 (21) = happyGoto action_36
action_41 (22) = happyGoto action_37
action_41 (23) = happyGoto action_38
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_35

action_43 (24) = happyShift action_39
action_43 (25) = happyShift action_40
action_43 (27) = happyShift action_41
action_43 (38) = happyShift action_42
action_43 (20) = happyGoto action_60
action_43 (21) = happyGoto action_36
action_43 (22) = happyGoto action_37
action_43 (23) = happyGoto action_38
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (24) = happyShift action_39
action_44 (25) = happyShift action_40
action_44 (27) = happyShift action_41
action_44 (38) = happyShift action_42
action_44 (20) = happyGoto action_59
action_44 (21) = happyGoto action_36
action_44 (22) = happyGoto action_37
action_44 (23) = happyGoto action_38
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (31) = happyShift action_58
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (24) = happyShift action_39
action_46 (25) = happyShift action_40
action_46 (27) = happyShift action_41
action_46 (28) = happyShift action_57
action_46 (38) = happyShift action_42
action_46 (20) = happyGoto action_56
action_46 (21) = happyGoto action_36
action_46 (22) = happyGoto action_37
action_46 (23) = happyGoto action_38
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (24) = happyShift action_39
action_47 (25) = happyShift action_40
action_47 (27) = happyShift action_41
action_47 (38) = happyShift action_42
action_47 (20) = happyGoto action_55
action_47 (21) = happyGoto action_36
action_47 (22) = happyGoto action_37
action_47 (23) = happyGoto action_38
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_6

action_49 _ = happyReduce_7

action_50 _ = happyReduce_22

action_51 (24) = happyShift action_29
action_51 (39) = happyShift action_30
action_51 (40) = happyShift action_31
action_51 (42) = happyShift action_32
action_51 (43) = happyShift action_33
action_51 (6) = happyGoto action_54
action_51 (7) = happyGoto action_19
action_51 (8) = happyGoto action_20
action_51 (9) = happyGoto action_21
action_51 (10) = happyGoto action_22
action_51 (11) = happyGoto action_23
action_51 (15) = happyGoto action_24
action_51 (16) = happyGoto action_25
action_51 (17) = happyGoto action_26
action_51 (18) = happyGoto action_27
action_51 (19) = happyGoto action_28
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (24) = happyShift action_53
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (28) = happyShift action_89
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (45) = happyShift action_88
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (29) = happyShift action_87
action_55 (30) = happyShift action_64
action_55 (32) = happyShift action_65
action_55 (33) = happyShift action_66
action_55 (34) = happyShift action_67
action_55 (35) = happyShift action_68
action_55 (36) = happyShift action_69
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (26) = happyShift action_85
action_56 (28) = happyShift action_86
action_56 (30) = happyShift action_64
action_56 (32) = happyShift action_65
action_56 (33) = happyShift action_66
action_56 (34) = happyShift action_67
action_56 (35) = happyShift action_68
action_56 (36) = happyShift action_69
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (29) = happyShift action_84
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (24) = happyShift action_39
action_58 (25) = happyShift action_40
action_58 (27) = happyShift action_41
action_58 (38) = happyShift action_42
action_58 (20) = happyGoto action_83
action_58 (21) = happyGoto action_36
action_58 (22) = happyGoto action_37
action_58 (23) = happyGoto action_38
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (28) = happyShift action_82
action_59 (30) = happyShift action_64
action_59 (32) = happyShift action_65
action_59 (33) = happyShift action_66
action_59 (34) = happyShift action_67
action_59 (35) = happyShift action_68
action_59 (36) = happyShift action_69
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (28) = happyShift action_81
action_60 (30) = happyShift action_64
action_60 (32) = happyShift action_65
action_60 (33) = happyShift action_66
action_60 (34) = happyShift action_67
action_60 (35) = happyShift action_68
action_60 (36) = happyShift action_69
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (28) = happyShift action_80
action_61 (30) = happyShift action_64
action_61 (32) = happyShift action_65
action_61 (33) = happyShift action_66
action_61 (34) = happyShift action_67
action_61 (35) = happyShift action_68
action_61 (36) = happyShift action_69
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (24) = happyShift action_39
action_62 (25) = happyShift action_40
action_62 (27) = happyShift action_41
action_62 (28) = happyShift action_79
action_62 (38) = happyShift action_42
action_62 (20) = happyGoto action_78
action_62 (21) = happyGoto action_36
action_62 (22) = happyGoto action_37
action_62 (23) = happyGoto action_38
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_26

action_64 (24) = happyShift action_39
action_64 (25) = happyShift action_40
action_64 (27) = happyShift action_41
action_64 (38) = happyShift action_42
action_64 (20) = happyGoto action_77
action_64 (21) = happyGoto action_36
action_64 (22) = happyGoto action_37
action_64 (23) = happyGoto action_38
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (24) = happyShift action_39
action_65 (25) = happyShift action_40
action_65 (27) = happyShift action_41
action_65 (38) = happyShift action_42
action_65 (20) = happyGoto action_76
action_65 (21) = happyGoto action_36
action_65 (22) = happyGoto action_37
action_65 (23) = happyGoto action_38
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (24) = happyShift action_39
action_66 (25) = happyShift action_40
action_66 (27) = happyShift action_41
action_66 (38) = happyShift action_42
action_66 (20) = happyGoto action_75
action_66 (21) = happyGoto action_36
action_66 (22) = happyGoto action_37
action_66 (23) = happyGoto action_38
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (24) = happyShift action_39
action_67 (25) = happyShift action_40
action_67 (27) = happyShift action_41
action_67 (38) = happyShift action_42
action_67 (20) = happyGoto action_74
action_67 (21) = happyGoto action_36
action_67 (22) = happyGoto action_37
action_67 (23) = happyGoto action_38
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (24) = happyShift action_39
action_68 (25) = happyShift action_40
action_68 (27) = happyShift action_41
action_68 (38) = happyShift action_42
action_68 (20) = happyGoto action_73
action_68 (21) = happyGoto action_36
action_68 (22) = happyGoto action_37
action_68 (23) = happyGoto action_38
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (24) = happyShift action_39
action_69 (25) = happyShift action_40
action_69 (27) = happyShift action_41
action_69 (38) = happyShift action_42
action_69 (20) = happyGoto action_72
action_69 (21) = happyGoto action_36
action_69 (22) = happyGoto action_37
action_69 (23) = happyGoto action_38
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (29) = happyShift action_71
action_70 (30) = happyShift action_64
action_70 (32) = happyShift action_65
action_70 (33) = happyShift action_66
action_70 (34) = happyShift action_67
action_70 (35) = happyShift action_68
action_70 (36) = happyShift action_69
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_25

action_72 (30) = happyShift action_64
action_72 (32) = happyShift action_65
action_72 (33) = happyShift action_66
action_72 (34) = happyShift action_67
action_72 (35) = happyShift action_68
action_72 (36) = happyShift action_69
action_72 _ = happyReduce_40

action_73 (30) = happyShift action_64
action_73 (32) = happyShift action_65
action_73 (33) = happyShift action_66
action_73 (34) = happyShift action_67
action_73 (35) = happyShift action_68
action_73 (36) = happyShift action_69
action_73 _ = happyReduce_39

action_74 (30) = happyShift action_64
action_74 (32) = happyShift action_65
action_74 (33) = happyShift action_66
action_74 (34) = happyShift action_67
action_74 (35) = happyShift action_68
action_74 (36) = happyShift action_69
action_74 _ = happyReduce_38

action_75 (30) = happyShift action_64
action_75 (32) = happyShift action_65
action_75 (33) = happyShift action_66
action_75 (34) = happyShift action_67
action_75 (35) = happyShift action_68
action_75 (36) = happyShift action_69
action_75 _ = happyReduce_37

action_76 (30) = happyShift action_64
action_76 (32) = happyShift action_65
action_76 (33) = happyShift action_66
action_76 (34) = happyShift action_67
action_76 (35) = happyShift action_68
action_76 (36) = happyShift action_69
action_76 _ = happyReduce_36

action_77 (30) = happyShift action_64
action_77 (32) = happyShift action_65
action_77 (33) = happyShift action_66
action_77 (34) = happyShift action_67
action_77 (35) = happyShift action_68
action_77 (36) = happyShift action_69
action_77 _ = happyReduce_41

action_78 (26) = happyShift action_96
action_78 (28) = happyShift action_97
action_78 (30) = happyShift action_64
action_78 (32) = happyShift action_65
action_78 (33) = happyShift action_66
action_78 (34) = happyShift action_67
action_78 (35) = happyShift action_68
action_78 (36) = happyShift action_69
action_78 _ = happyFail (happyExpListPerState 78)

action_79 _ = happyReduce_43

action_80 _ = happyReduce_42

action_81 (44) = happyShift action_95
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (44) = happyShift action_94
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (29) = happyShift action_93
action_83 (30) = happyShift action_64
action_83 (32) = happyShift action_65
action_83 (33) = happyShift action_66
action_83 (34) = happyShift action_67
action_83 (35) = happyShift action_68
action_83 (36) = happyShift action_69
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_27

action_85 (24) = happyShift action_39
action_85 (25) = happyShift action_40
action_85 (27) = happyShift action_41
action_85 (38) = happyShift action_42
action_85 (20) = happyGoto action_92
action_85 (21) = happyGoto action_36
action_85 (22) = happyGoto action_37
action_85 (23) = happyGoto action_38
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (29) = happyShift action_91
action_86 _ = happyFail (happyExpListPerState 86)

action_87 _ = happyReduce_19

action_88 _ = happyReduce_23

action_89 (44) = happyShift action_90
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (24) = happyShift action_29
action_90 (39) = happyShift action_30
action_90 (40) = happyShift action_31
action_90 (42) = happyShift action_32
action_90 (43) = happyShift action_33
action_90 (6) = happyGoto action_102
action_90 (7) = happyGoto action_19
action_90 (8) = happyGoto action_20
action_90 (9) = happyGoto action_21
action_90 (10) = happyGoto action_22
action_90 (11) = happyGoto action_23
action_90 (15) = happyGoto action_24
action_90 (16) = happyGoto action_25
action_90 (17) = happyGoto action_26
action_90 (18) = happyGoto action_27
action_90 (19) = happyGoto action_28
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_28

action_92 (28) = happyShift action_101
action_92 (30) = happyShift action_64
action_92 (32) = happyShift action_65
action_92 (33) = happyShift action_66
action_92 (34) = happyShift action_67
action_92 (35) = happyShift action_68
action_92 (36) = happyShift action_69
action_92 _ = happyFail (happyExpListPerState 92)

action_93 _ = happyReduce_18

action_94 (24) = happyShift action_29
action_94 (39) = happyShift action_30
action_94 (40) = happyShift action_31
action_94 (42) = happyShift action_32
action_94 (43) = happyShift action_33
action_94 (6) = happyGoto action_100
action_94 (7) = happyGoto action_19
action_94 (8) = happyGoto action_20
action_94 (9) = happyGoto action_21
action_94 (10) = happyGoto action_22
action_94 (11) = happyGoto action_23
action_94 (15) = happyGoto action_24
action_94 (16) = happyGoto action_25
action_94 (17) = happyGoto action_26
action_94 (18) = happyGoto action_27
action_94 (19) = happyGoto action_28
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (24) = happyShift action_29
action_95 (39) = happyShift action_30
action_95 (40) = happyShift action_31
action_95 (42) = happyShift action_32
action_95 (43) = happyShift action_33
action_95 (6) = happyGoto action_99
action_95 (7) = happyGoto action_19
action_95 (8) = happyGoto action_20
action_95 (9) = happyGoto action_21
action_95 (10) = happyGoto action_22
action_95 (11) = happyGoto action_23
action_95 (15) = happyGoto action_24
action_95 (16) = happyGoto action_25
action_95 (17) = happyGoto action_26
action_95 (18) = happyGoto action_27
action_95 (19) = happyGoto action_28
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (24) = happyShift action_39
action_96 (25) = happyShift action_40
action_96 (27) = happyShift action_41
action_96 (38) = happyShift action_42
action_96 (20) = happyGoto action_98
action_96 (21) = happyGoto action_36
action_96 (22) = happyGoto action_37
action_96 (23) = happyGoto action_38
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_44

action_98 (28) = happyShift action_107
action_98 (30) = happyShift action_64
action_98 (32) = happyShift action_65
action_98 (33) = happyShift action_66
action_98 (34) = happyShift action_67
action_98 (35) = happyShift action_68
action_98 (36) = happyShift action_69
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (45) = happyShift action_106
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (45) = happyShift action_105
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (29) = happyShift action_104
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (45) = happyShift action_103
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_24

action_104 _ = happyReduce_29

action_105 (41) = happyShift action_108
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_21

action_107 _ = happyReduce_45

action_108 (44) = happyShift action_109
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (24) = happyShift action_29
action_109 (39) = happyShift action_30
action_109 (40) = happyShift action_31
action_109 (42) = happyShift action_32
action_109 (43) = happyShift action_33
action_109 (6) = happyGoto action_110
action_109 (7) = happyGoto action_19
action_109 (8) = happyGoto action_20
action_109 (9) = happyGoto action_21
action_109 (10) = happyGoto action_22
action_109 (11) = happyGoto action_23
action_109 (15) = happyGoto action_24
action_109 (16) = happyGoto action_25
action_109 (17) = happyGoto action_26
action_109 (18) = happyGoto action_27
action_109 (19) = happyGoto action_28
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (45) = happyShift action_111
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_20

happyReduce_1 = happySpecReduce_2  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Programm happy_var_1 happy_var_2
	)
happyReduction_1 _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Single happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn5
		 (Function0 happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn5
		 (Function1 happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn5
		 (Function2 happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  6 happyReduction_6
happyReduction_6 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (ADeclare happy_var_1 happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  6 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Actions happy_var_1 happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  6 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (OneDeclare happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (OneAction happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (AChange happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 (AIf happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn7
		 (AWhile happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  7 happyReduction_13
happyReduction_13 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn7
		 (AWrite happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  7 happyReduction_14
happyReduction_14 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn7
		 (AReturn happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  7 happyReduction_15
happyReduction_15 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn7
		 (ARun0 happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  7 happyReduction_16
happyReduction_16 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn7
		 (ARun1 happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  7 happyReduction_17
happyReduction_17 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn7
		 (ARun2 happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 5 8 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_2)) `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Declaration happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 9 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (Change happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 11 10 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (EIf happy_var_3 happy_var_6 happy_var_10
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 7 11 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (EWhile happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 7 12 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_2)) `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Def0 happy_var_1 happy_var_2 happy_var_6
	) `HappyStk` happyRest

happyReduce_23 = happyReduce 9 13 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_5)) `HappyStk`
	(HappyTerminal (VarT happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_2)) `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (Def1 happy_var_1 happy_var_2 happy_var_4 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_24 = happyReduce 12 14 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_11) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_8)) `HappyStk`
	(HappyTerminal (VarT happy_var_7)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_5)) `HappyStk`
	(HappyTerminal (VarT happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_2)) `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 (Def2 happy_var_1 happy_var_2 happy_var_4 happy_var_5 happy_var_7 happy_var_8 happy_var_11
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 4 15 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (Write happy_var_3
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_3  16 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (EReturn happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 4 17 happyReduction_27
happyReduction_27 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (Run0 happy_var_1
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 5 18 happyReduction_28
happyReduction_28 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (Run1 happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 7 19 happyReduction_29
happyReduction_29 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Run2 happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_30 = happySpecReduce_1  20 happyReduction_30
happyReduction_30 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (VF0 happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  20 happyReduction_31
happyReduction_31 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn20
		 (VF1 happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  20 happyReduction_32
happyReduction_32 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn20
		 (VF2 happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  20 happyReduction_33
happyReduction_33 (HappyTerminal (VarT happy_var_1))
	 =  HappyAbsSyn20
		 (Var happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  20 happyReduction_34
happyReduction_34 (HappyTerminal (NumT happy_var_1))
	 =  HappyAbsSyn20
		 (Num happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  20 happyReduction_35
happyReduction_35 (HappyTerminal (LStr happy_var_1))
	 =  HappyAbsSyn20
		 (Str happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  20 happyReduction_36
happyReduction_36 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (Sum happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  20 happyReduction_38
happyReduction_38 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  20 happyReduction_39
happyReduction_39 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (ELess happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  20 happyReduction_40
happyReduction_40 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EGreater happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  20 happyReduction_41
happyReduction_41 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (EEqual happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  20 happyReduction_42
happyReduction_42 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  21 happyReduction_43
happyReduction_43 _
	_
	(HappyTerminal (VarT happy_var_1))
	 =  HappyAbsSyn21
		 (F0 happy_var_1
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happyReduce 4 22 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (F1 happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_45 = happyReduce 6 23 happyReduction_45
happyReduction_45 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (VarT happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (F2 happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 46 46 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	VarT happy_dollar_dollar -> cont 24;
	NumT happy_dollar_dollar -> cont 25;
	Comma -> cont 26;
	LeftP -> cont 27;
	RightP -> cont 28;
	Semicolon -> cont 29;
	VeryEqual -> cont 30;
	Equal -> cont 31;
	Plus -> cont 32;
	Minus -> cont 33;
	Multiply -> cont 34;
	Less -> cont 35;
	Greater -> cont 36;
	Lessless -> cont 37;
	LStr happy_dollar_dollar -> cont 38;
	LIf -> cont 39;
	LWhile -> cont 40;
	LElse -> cont 41;
	LReturn -> cont 42;
	Print -> cont 43;
	Start -> cont 44;
	End -> cont 45;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 46 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = (>>=)
happyReturn :: () => a -> Either String a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Either String a
happyError' = (\(tokens, _) -> parseError tokens)
parseExpr tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError = fail "Parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
