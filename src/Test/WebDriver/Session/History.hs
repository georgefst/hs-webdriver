
module Test.WebDriver.Session.History where

import Control.Exception (SomeException)
import Data.ByteString.Lazy (ByteString)
import Network.HTTP.Client (Request, Response)


data SessionHistory = SessionHistory
    { histRequest :: Request
    , histResponse :: Either SomeException (Response ByteString)
    , histRetryCount :: Int
    }
    deriving (Show)
