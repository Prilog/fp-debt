module TestData 
  ( hello
  , helloKitty
  , csum ) where

import CDSL

hello :: CDSL r ()
hello = do
  cout (string "hello")

helloKitty :: r String -> CDSL r ()
helloKitty name = do
  cout $ (string "hello") +% (get name)

csum :: r Int -> r Int -> CDSL r Int
csum x y = do
  creturn $ (get x) +% (get y)