{-# LANGUAGE TypeOperators,TypeFamilies,DefaultSignatures,FlexibleContexts #-}
data Level = Low | Midium | High deriving Show

data U = U

data (:*:) a b = a :*: b
data (:+:) a b = L a | R b

instance Eq U where
    U == U = True

instance (Eq a, Eq b) => Eq (a :+: b) where
    L a == L b = a == b
    R a == R b = a == b
    
instance (Eq a, Eq b) => Eq (a :*: b) where
    (a1 :*: b1) == (a2 :*: b2) 
                = a1 == a2 && b1 == b2

data Bool' = False' | True' deriving Show 
-- type Bool' = U :+: U

fromBool :: Bool' -> U :+: U
fromBool False' = L U
fromBool True'  = R U

toBool :: U :+: U -> Bool'
toBool (L U) = False'
toBool (R U) = True'

instance Eq Bool' where
     a == b = fromBool a == fromBool b

class Generic a where
      type Rep a :: *
      from :: a -> Rep a       
      to   :: Rep a -> a  

instance Generic Bool' where
      type Rep Bool' = U :+: U
      from = fromBool
      to = toBool

-- by library provider
class MyEq a where
      myEq :: a -> a -> Bool
      default myEq :: (Generic a, MyEq (Rep a)) 
                                  => a -> a -> Bool
      myEq a b = myEq (from a) (from b)


instance MyEq U where myEq = (==)
instance (Eq a,Eq b) => MyEq (a :*: b) where myEq = (==)
instance (Eq a,Eq b) => MyEq (a :+: b) where myEq = (==)

-- by GHC
instance Generic Level where
     type Rep Level = (U :+: U) :+: U
     from Low = L (L U)
     from Midium = (L (R U))
     from High  = R U
     to (L (L U)) = Low
     to (L (R U)) = Midium
     to (R U) = High

instance MyEq Level


