module Main where

import qualified Data.Text.Lazy.IO as T
import           Lib
import           Lucid

resume :: Resume
resume = Resume
  "Xy Ren" [ghContact "re-xyr", mailContact "xy.r@outlook.com"]
  [ Section "Affiliation"
    [Aff plct, Aff mlabs, Aff taichi]
  , Section "Open Source Contribution"
    [Proj aya]
  , Section "Personal Projects"
    [Proj cleff, Proj avail, Proj aqn]
  -- , Section "Other activities" $ List other
  , Section "Skills" $ List skills
  ]

plct :: Affiliation
plct = Affiliation
  { affTitle = "PLCT Lab"
  , affSubtitle = Just "Intelligent Software Research Center, China Academy of Science"
  , affPosition = "Intern Research Engineer"
  , affLocation = "Remote"
  , affFrom = (2020, 10)
  , affTill = Just (2021, 10)
  , affContent = List
    [ "Investigated several techniques in implementation of type theories and programming languages"
    , Desc $ "Contributed heavily to the open source proof assistant " <> link (gh "aya-prover/aya-dev") "Aya Prover"
    ]
  }

mlabs :: Affiliation
mlabs = Affiliation
  { affTitle = "MLabs"
  , affSubtitle = Nothing
  , affPosition = "Software Consultant (Haskell & Plutus)"
  , affLocation = "Remote"
  , affFrom = (2021, 10)
  , affTill = Nothing
  , affContent = List
    [ Desc do
        "Contributed to "
        link (gh "Liqwid-Labs/plutus-extra") "open source utility libraries"
        " for the Plutus smart contract language"
    , "Improved the testing experience of Plutus smart contracts"
    ]
  }

taichi :: Affiliation
taichi = Affiliation
  { affTitle = "Taichi Graphics"
  , affSubtitle = Nothing
  , affPosition = "Intern Infrastructure Engineer"
  , affLocation = "Remote"
  , affFrom = (2021, 11)
  , affTill = Nothing
  , affContent = List
    [ Desc do
        "Added short-circuit boolean operators to the "
        link (gh "taichi-dev/taichi") "Taichi compiler"
    , "Refactored several AST passes to make porting other languages to Taichi AST easier"
    ]
  }

aya :: Project
aya = Project "Aya Prover" "https://www.aya-prover.org"
  [ "A programming language and a proof assistant designed for formalizing maths and type-directed programming"
  , List
    [ "Core contributor, ranked 3rd in total commits"
    , "Implemented critical components: variable name resolution, type-directed unification and module system"
    , "Maintainer of project documentation and designer of project logo"
    ]
  ]

avail :: Project
avail = Project "avail" "https://github.com/re-xyr/avail"
  [ "Zero-overhead capability management mechanism for monad transformers"
  ]

cleff :: Project
cleff = Project "cleff" "https://github.com/re-xyr/cleff"
  [ "Fast and consise extensible effects in Haskell that works seamlessly with the current ecosystem"
  ]

aqn :: Project
aqn = Project "aqn" "https://github.com/re-xyr/aqn"
  [ "Simple implementation of efficient dependent type elaboration using HOAS normalization-by-evaluation"
  ]

skills :: [Content]
skills =
  [ Desc do
      strong_ "Programming languages: "
      "Comfortable with Haskell (2 years), JavaScript (3 years), TypeScript (3 years), Agda, Java, Kotlin; Able to read C, C++, Coq, Idris, Arend"
  , Desc do
      strong_ "Compiler and PLT: "
      "Familiar with compiler frontends and type systems, able to implement algorithms like bidirectional typechecking, higher-order metavariable solving and type-directed unification"
  , Desc do
      strong_ "Type theory: "
      "Learned about several flavors of the lambda calculus, such as Martin-Löf type theory; also have basic understanding in relevant fields, including category theory and homotopy type theory"
  , Desc do
      strong_ "Web: "
      "Experienced with Node.js and TypeScript; able to use Vue.js and willing to learn about other frameworks"
  , Desc do
      strong_ "Language: "
      "English: Advanced (TOEFL 112); Chinese: Native"
  , "Open to learning new languages, technologies and concepts"
  ]

main :: IO ()
main = T.putStr $ convert resume
