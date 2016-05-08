{-# LANGUAGE DeriveGeneric,DeriveAnyClass #-}
{-# OPTIONS_GHC -ddump-deriv #-}
import Data.Binary
import qualified Data.Aeson as J
import GHC.Generics
data Person = Person {name :: String , age :: Int} deriving (Generic, J.ToJSON, J.FromJSON,Show,Binary)

song = Person "Song" 27
