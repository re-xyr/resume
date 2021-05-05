module Style where

import           Clay
import           Clay.Media (print)
import           Prelude    hiding (print, (**))

boldify, unboldify, italicize :: Css
boldify = fontWeight (400 `weight`)
unboldify = fontWeight (300 `weight`)
italicize = fontStyle italic

centerize, demarginalize :: Css
centerize = do
  marginLeft auto
  marginRight auto
demarginalize = margin nil nil nil nil

style :: Css
style = do
  importUrl "https://fonts.googleapis.com/css2?family=Source+Serif+Pro:ital,wght@0,300;0,400;1,300;1,400&display=swap"
  suppressDefaults
  generalStyle
  boxes
  contacts

suppressDefaults :: Css
suppressDefaults = do
  star ? do
    boxSizing borderBox
  body ? do
    demarginalize

generalStyle :: Css
generalStyle = do
  body ? do
    unboldify
    fontFamily ["Source Serif Pro"] [serif]
    fontSize (13 `px`)
    lineHeight (1.5 `em`)
  h1 <> h2 ? do
    unboldify
  h3 <> strong ? do
    boldify
  h3 <> p <> ul ? do
    demarginalize
  ul <> ol ? do
    paddingLeft (30 `px`)
  h2 ? do
    borderTop solid (1 `px`) (rgb 0xdd 0xdd 0xdd)
    margin (0.8 `em`) nil (0.4 `em`) nil
    paddingTop (5 `px`)
  h3 ? do
    fontSize (1.1 `em`)
  a <> a # visited ? do
    color (rgb 0 68 102)
  query print [] $ a ? do
    textDecoration none

boxes :: Css
boxes = do
  ".container" ? do
    centerize
    maxWidth (85 `vw`)
    maxHeight (90 `vh`)
    paddingTop (5 `vh`)
  query print [] $ ".container" ? do
    paddingBottom nil
  ".entry" ? do
    margin nil (2 `px`) (0.4 `em`) (2 `px`)
  ".aside" ? do
    float floatRight
  ".subtitle" ? do
    italicize
  ".twofold" ? do
    unboldify

contacts :: Css
contacts = do
  ".contacts" ? do
    padding nil nil nil nil
  ".contacts-item" ? do
    display inlineBlock
    marginRight (20 `px`)
  ".contacts-item" ** strong ? do
    marginRight (5 `px`)
