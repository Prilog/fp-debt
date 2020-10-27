module CDSLResult ( cmain, programm ) where

import CDSL

satisfy :: r Int -> r Int -> CDSL r Bool
satisfy x y =
  cif ((get x) <% (int (10))) (
    cif ((get y) >% (int (4))) (
      creturn (bool True)
    ) (
      creturn (bool False)
    )
  ) (
    creturn (bool False)
  )

cmain :: CDSL r Int
cmain =
  vint (int (7)) (\a -> 
  vint (int (7)) (\b -> 
  cwhile (runf2 "satisfy" satisfy (get a) (get b)) (
    cout (get a) >>
    cout (string (" ")) >>
    cout (get b) >>
    cout (string ("\n")) >>
    a =% ((get a) +% (int (1))) >>
    b =% ((get b) -% (int (1)))) >>
  cout (string ("finished\n")) >>
  creturn (int (0))))

programm :: CDSL r ()
programm =
  def2 "bool satisfy" "int" "int" satisfy >>
  def0 "int main" cmain