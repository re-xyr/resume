module Convert where

import           Clay           (render)
import           Data.Foldable  (traverse_)
import           Data.Text.Lazy (Text, toStrict)
import           Lucid
import           Style          (style)
import           Template

convert :: Resume -> Text
convert resume = renderText $ doctypehtml_ do
  head_ do
    meta_ [charset_ "UTF-8"]
    meta_ [httpEquiv_ "X-UA-Compatible", content_ "IE=edge"]
    meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1.0"]
    title_ "Resume"
    style_ $ toStrict $ render style
  body_ $ convertResume resume

convertResume :: Resume -> Html ()
convertResume (Resume nm con sec) = div_ [class_ "container"] do
  h1_ $ toHtml nm
  convertContacts con
  traverse_ convertSection sec

convertContacts :: [Contact] -> Html ()
convertContacts con = ul_ [class_ "contacts"] $
  traverse_ convertContact con
  where
    convertContact (Contact m v l) = li_ [class_ "contacts-item"] do
      strong_ $ toHtml (m <> " ")
      case l of
        Nothing -> toHtml v
        Just l' -> a_ [href_ l'] $ toHtml v

convertSection :: Section -> Html ()
convertSection (Section titl con) = do
  h2_ $ toHtml titl
  convertContent con

convertContent :: Content -> Html ()
convertContent = \case
  Aff aff   -> convertAff aff
  Proj proj -> convertProj proj
  List cons -> ul_ $ traverse_ (li_ . convertContent) cons
  Desc raw  -> p_ raw
  Cat cons  -> traverse_ convertContent cons

convertAff :: Affiliation -> Html ()
convertAff (Affiliation titl subtitl loc pos from til con) = div_ [class_ "entry"] do
  p_ [classes_ ["aside", "subtitle"]] $ toHtml $
    loc <> ", " <> showDate from <> "–" <> maybe "Present" showDate til
  h3_ [classes_ ["twofold", "subtitle"]] $
    strong_ (toHtml titl) <> ", " <> toHtml pos
  case subtitl of
    Nothing -> pure ()
    Just s  -> p_ [class_ "subtitle"] $ toHtml s
  convertContent con

convertProj :: Project -> Html ()
convertProj (Project titl lin con) = div_ [class_ "entry"] do
  p_ [classes_ ["aside", "subtitle"]] $ a_ [href_ lin] $ toHtml lin
  h3_ [class_ "subtitle"] $ toHtml titl
  convertContent con
