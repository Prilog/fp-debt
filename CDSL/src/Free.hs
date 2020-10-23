module Free
  ( Free(..)
  , pack  
  ) where

-- | Free-monad
data Free f a = Pure a | Free (f (Free f a))

instance Functor f => Monad (Free f) where
  return = Pure

  Pure a >>= f = f a
  Free m >>= f = Free ((>>= f) <$> m)

instance Functor f => Applicative (Free f) where
  pure = return
  fs <*> xs = fs >>= \f -> xs >>= \x -> return (f x)

instance Functor f => Functor (Free f) where
  fmap f xs = Pure f <*> xs

-- | Packs Functor into Free (Functor (Pure t))
pack :: (Functor f) => f t -> Free f t
pack action = Free (fmap Pure action)