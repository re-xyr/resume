module Template where

import           Data.String (IsString (fromString))
import           Data.Text   (Text)
import qualified Data.Text   as T
import           GHC.Exts    (IsList (Item, fromList, toList))
import           Lucid       (Html, toHtml)

data Resume = Resume
  { name     :: Text
  , contacts :: [Contact]
  , sections :: [Section]
  }

type Link = Text

data Contact = Contact
  { conMethod :: Text
  , conValue  :: Text
  , conLink   :: Maybe Link
  }

contactTemplate :: Text -> (Text -> Maybe Link) -> Text -> Contact
contactTemplate nm toLink val = Contact
  { conMethod = nm
  , conValue = val
  , conLink = toLink val
  }

mailto, gh, twitter, https :: Text -> Link
mailto = ("mailto:" <>)
gh = https . ("github.com/" <>)
twitter = https . ("twitter.com/" <>)
https = ("https://" <>)

mailContact, ghContact, twitterContact, blogContact :: Text -> Contact
mailContact = contactTemplate "Email" (Just . mailto)
ghContact = contactTemplate "GitHub" (Just . gh)
twitterContact = contactTemplate "Twitter" (Just . twitter)
blogContact = contactTemplate "Blog" (Just . https)

data Section = Section
  { title   :: Text
  , content :: Content
  }

data Content
  = Aff Affiliation
  | Proj Project
  | List [Content]
  | Desc (Html ())
  | Cat [Content]

data Affiliation = Affiliation
  { affTitle    :: Text
  , affSubtitle :: Maybe Text
  , affLocation :: Text
  , affPosition :: Text
  , affFrom     :: (Int, Int)
  , affTill     :: Maybe (Int, Int)
  , affContent  :: Content
  }

showDate :: (Int, Int) -> Text
showDate (yr, mo) = T.pack (show yr) <> "/" <> T.justifyRight 2 '0' (T.pack $ show mo)

data Project = Project
  { projTitle   :: Text
  , projLink    :: Text
  , projContent :: Content
  }

instance IsList Content where
  type Item Content = Content
  fromList = Cat
  toList c = case c of
    Cat xs -> xs
    _      -> [c]

instance Semigroup Content where
  Cat xs <> Cat ys = Cat (xs <> ys)
  Cat xs <> y      = Cat (xs <> [y])
  x <> Cat ys      = Cat (x : ys)
  x <> y           = Cat [x, y]

instance Monoid Content where
  mempty = Cat []

instance IsString Content where
  fromString = Desc . toHtml
