{-# LANGUAGE OverloadedStrings #-}
module Test.WebDriver.Commands.Internal 
       ( RequestMethod(..), Header(..)
       , module Test.WebDriver.Commands.Internal
       ) where

import Test.WebDriver.Types
import Test.WebDriver.Internal
import Data.Aeson
import Network.HTTP (RequestMethod(..), Header(..))

import qualified Data.Text as T
import Data.Text (Text)

import Control.Monad.State.Strict (get)
import Control.Exception.Lifted (throwIO)


doCommand :: (ToJSON a, FromJSON b) => RequestMethod -> Text -> a -> WD b
doCommand = doCommand' []

doSessCommand :: (ToJSON a, FromJSON b) => RequestMethod -> Text -> a -> WD b
doSessCommand = doSessCommand' []

doElemCommand :: (ToJSON a, FromJSON b) => 
                 RequestMethod -> Element -> Text -> a -> WD b
doElemCommand = doElemCommand' []

doWinCommand :: (ToJSON a, FromJSON b) => 
                RequestMethod -> WindowHandle -> Text -> a -> WD b
doWinCommand = doWinCommand' []

doStorageCommand :: (ToJSON a, FromJSON b) =>
                    RequestMethod -> WebStorageType -> Text -> a -> WD b
doStorageCommand = doStorageCommand' []

doCommand' :: (ToJSON a, FromJSON b) => 
              [Header] -> RequestMethod -> Text -> a -> WD b  
doCommand' headers method path args = do
  r <- mkRequest headers method path args
  --liftIO . print $ r
  handleHTTPErr r
  --liftIO . print . rspBody $ r
  handleHTTPResp r

doSessCommand' :: (ToJSON a, FromJSON b) => 
                  [Header] -> RequestMethod -> Text -> a -> WD b
doSessCommand' headers method path args = do
  WDSession { wdSessId = mSessId } <- get
  case mSessId of 
      Nothing -> throwIO . NoSessionId $ msg
        where 
          msg = "No session ID found when making request for relative URL "
                ++ show path
      Just (SessionId sId) -> doCommand' headers method 
                              (T.concat ["/session/", sId, path]) args

doWinCommand' :: (ToJSON a, FromJSON b) => 
                 [Header] -> RequestMethod -> WindowHandle -> Text -> a 
                 -> WD b
doWinCommand' h m (WindowHandle w) path a = 
  doSessCommand' h m (T.concat ["/window/", w, path]) a

doElemCommand' :: (ToJSON a, FromJSON b) => 
                  [Header] -> RequestMethod -> Element -> Text -> a -> WD b
doElemCommand' h m (Element e) path a =
  doSessCommand' h m (T.concat ["/element/", e, path]) a

doStorageCommand' :: (ToJSON a, FromJSON b) =>
                     [Header] -> RequestMethod -> WebStorageType -> Text -> a
                     -> WD b
doStorageCommand' h m s path a = doSessCommand' h m (T.concat ["/", s', path]) a
  where s' = case s of
          LocalStorage -> "local_storage"
          SessionStorage -> "session_storage"