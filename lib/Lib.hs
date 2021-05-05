module Lib (
  Resume(..), Contact(..), Section(..), Content(..), Project(..), Affiliation(..),
  mailto, gh, twitter, https, ghContact, mailContact, twitterContact, blogContact,
  convert, link) where

import           Convert
import           Data.Text (Text)
import           Lucid
import           Template

link :: Link -> Text -> Html ()
link lnk = a_ [href_ lnk] . toHtml
