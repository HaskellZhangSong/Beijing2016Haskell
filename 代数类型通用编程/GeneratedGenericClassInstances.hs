{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -ddump-deriv #-}

module GenerateGenericClassInstances where
import GHC.Generics
data G = GInt {g :: Int} deriving Generic

-- > datatypeName (undefined :: D1 D1G (C1 C1_0G (S1 S1_0_0G (Rec0 Int))) ())
-- > conName (undefined :: C1 C1_0G (S1 S1_0_0G (Rec0 Int)) ())
-- > selName (undefined :: S1 S1_0_0G (Rec0 Int) ())
