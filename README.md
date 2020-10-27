# Dolg po FP
## Executing
Print `./executor` to start easy execution. 
It will require name of source file, interprete it into haskell DSL and compile.
As a next step you will be allowed to execute this file by printing `exe` or to iterprete it to c++ back
by writting output file name.

Notice that you should wait untill script compile generated code.

## Testing
There are two ways of testing implemented here.

Run `stack test` in order to run unit test of DSL printer.

Run `./tester` to start complete testing of files in `/test` directory. Each test has an unique name, source .cpp file, input .in file and output .out file.

## Examples
There are 4 examples:

* example.cpp - shows many features which have been implemented.
* example2.cpp - 6th fibonacci number calculation
* example3.cpp - endless loop to kill your pc
* example4.cpp - simple evaluator with while structure
