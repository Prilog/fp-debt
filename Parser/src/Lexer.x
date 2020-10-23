{
module Lexer where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$underline = _
$dot = .
$quote = "

tokens :-
  $white+                    ;
  ($digit)+($dot ($digit)+)? { \s -> NumT s }
  "("                        { \_ -> LeftP }
  ")"                        { \_ -> RightP }
  ";"                        { \_ -> Semicolon }
  "=="                       { \_ -> VeryEqual }
  "="                        { \_ -> Equal }
  "+"                        { \_ -> Plus }
  "-"                        { \_ -> Minus }
  "*"                        { \_ -> Multiply }
  ","                        { \_ -> Comma }
  "<<"                       { \_ -> Lessless }
  "<"                        { \_ -> Less }
  ">"                        { \_ -> Greater }
  "if"                       { \_ -> LIf }
  "{"                        { \_ -> Start }
  "}"                        { \_ -> End }
  $quote [^$quote]* $quote           { \s -> LStr s }
  "while"                    { \_ -> LWhile }
  "else"                     { \_ -> LElse }
  "cout"                     { \_ -> Print }
  "return"                   { \_ -> LReturn }
  $alpha [$alpha $digit $underline]*    { \s -> VarT s }

{
data Token = 
            LeftP
          | RightP
          | Semicolon
          | VeryEqual
          | Equal
          | Plus
          | Minus
          | Multiply
          | Comma
          | Lessless
          | Less
          | Greater
          | LStr String
          | LIf
          | LWhile
          | LElse
          | LReturn
          | Print
          | Start
          | End
          | NumT String
          | VarT String
          deriving (Show, Eq)
}