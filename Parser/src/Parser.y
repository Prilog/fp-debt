{
module Parser where

import Lexer
import Expression
}

%name      parseExpr
%tokentype { Token }
%error     { parseError }
%monad     { Either String }

%token VAR      { VarT $$ }
%token NUM      { NumT $$ }
%token ','      { Comma }
%token '('      { LeftP }
%token ')'      { RightP }
%token ';'      { Semicolon }
%token EQUAL    { VeryEqual }
%token '='      { Equal }
%token '+'      { Plus }
%token '-'      { Minus }
%token '*'      { Multiply }
%token '<'      { Less }
%token '>'      { Greater }
%token LESSLESS { Lessless }
%token STR      { LStr $$ }
%token IF       { LIf }
%token WHILE    { LWhile }
%token ELSE     { LElse }
%token RETURN   { LReturn }
%token PRINT    { Print }
%token START    { Start }
%token END      { End }

%%

Programm :: { Programm }
  : Function Programm       { Programm $1 $2 }
  | Function                { Single $1 }

Function :: { Function }
  : Def0                    { Function0 $1 }
  | Def1                    { Function1 $1 }
  | Def2                    { Function2 $1 }

Actions :: { Actions }
  : Declaration Actions     { ADeclare $1 $2 }
  | Action Actions          { Actions $1 $2 }
  | Declaration             { OneDeclare $1 }
  | Action                  { OneAction $1 }

Action :: { Action }
  : Change { AChange $1 }
  | If { AIf $1 }
  | While { AWhile $1 }
  | Write { AWrite $1 }
  | Return { AReturn $1 }
  | ProcedureRun0 { ARun0 $1 }
  | ProcedureRun1 { ARun1 $1 }
  | ProcedureRun2 { ARun2 $1 }

Declaration :: { Declaration }
  : VAR VAR '=' Value ';' { Declaration $1 $2 $4 }

Change :: { Change }
  : VAR '=' Value ';' { Change $1 $3 }

If :: { EIf }
  : IF '(' Value ')' START Actions END ELSE START Actions END { EIf $3 $6 $10 }

While :: { EWhile }
  : WHILE '(' Value ')' START Actions END { EWhile $3 $6 }

Def0 :: { Def0 }
  : VAR VAR '(' ')' START Actions END { Def0 $1 $2 $6 }

Def1 :: { Def1 }
  : VAR VAR '(' VAR VAR ')' START Actions END { Def1 $1 $2 $4 $5 $8 }

Def2 :: { Def2 }
  : VAR VAR '(' VAR VAR ',' VAR VAR ')' START Actions END { Def2 $1 $2 $4 $5 $7 $8 $11}

Write :: { Write }
  : PRINT LESSLESS Value ';' { Write $3 }

Return :: { EReturn }
  : RETURN Value ';' { EReturn $2 }

ProcedureRun0 :: { Run0 }
  : VAR '(' ')' ';' { Run0 $1 }

ProcedureRun1 :: { Run1 }
  : VAR '(' Value ')' ';' { Run1 $1 $3 }

ProcedureRun2 :: { Run2 }
  : VAR '(' Value ',' Value ')' ';' { Run2 $1 $3 $5 }

Value :: { Value }
  : Function0 { VF0 $1 }
  | Function1 { VF1 $1 }
  | Function2 { VF2 $1 }
  | VAR { Var $1 }
  | NUM { Num $1 }
  | STR { Str $1 }
  | Value '+' Value { Sum $1 $3 }
  | Value '-' Value { Sub $1 $3 }
  | Value '*' Value { Mul $1 $3 }
  | Value '<' Value { ELess $1 $3 }
  | Value '>' Value { EGreater $1 $3 }
  | Value EQUAL Value { EEqual $1 $3 }
  | '(' Value ')' { $2 }

Function0 :: { F0 }
  : VAR '(' ')' { F0 $1 }

Function1 :: { F1 }
  : VAR '(' Value ')' { F1 $1 $3 }

Function2 :: { F2 }
  : VAR '(' Value ',' Value ')' { F2 $1 $3 $5 }

{
parseError = fail "Parse error"
}
