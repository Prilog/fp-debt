module CDSLResult ( cmain, programm ) where

import CDSL

fib :: r Int -> CDSL r Int
fib x =
  cif ((get x) <% (int (2))) (
    creturn (int (1))
  ) (
    creturn ((runf1 "fib" fib ((get x) -% (int (1)))) +% (runf1 "fib" fib ((get x) -% (int (2)))))
  )

cmain :: CDSL r Int
cmain =
  vint (int (6)) (\times -> 
  vint (runf1 "fib" fib (get times)) (\result -> 
  cout (get result) >>
  creturn (int (0))))

programm :: CDSL r ()
programm =
  def1 "int fib" "int" fib >>
  def0 "int main" cmain