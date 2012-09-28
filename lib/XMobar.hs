{-
  Keep the xmobar configuration in here, since it's not possible to keep comments in .xmobarrc

  TODO: Use the pretty print combinators to print the document:
  - Text.PrettyPrint.HughesPJ: http://hackage.haskell.org/packages/archive/pretty/latest/doc/html/Text-PrettyPrint-HughesPJ.html
-}
module XMobar
       ( getXMobarRC
       ) where

import System.Directory --(getHomeDirectory)
import System.FilePath.Posix

newtype Config = Config { options :: [Option] } --deriving (Show)
data    Option = Opt String String
               | OptList String [String]
               --deriving (Show)

instance Show Config where
  show (Config options) = "Config { " ++ show options ++ " }"

instance Show Option where
  show (Opt key value) = concat [key, " = ", show value]
  show (OptList key values) = concat [key, " = ", show values ]
                                               
                              
                              
defaultXMobarRC = Config $
                  [ Opt "font" "-*-Fixed-Bold-R-Normal-*-12-*-*-*-*-*-*-*"
                  , Opt "bgColor" "black"
                  , Opt "fgColor" "grey"
                  , Opt "lowerOnStart" $ show True
                  , OptList "commands" [ "Run Swap [] 10"
                                       , "Run Battery [] 10"
                                       ]
                  ]

-- | Return a string representation of an xmobar configuration that can be written to a file.
printConfig conf = map (indent ++) $ map show $ options conf
  where indent = "   "

xmobarrc = ".xmobarrc" :: String

getXMobarRC :: IO FilePath
getXMobarRC = getHomeDirectory >>= (\h -> return $ h </> xmobarrc)
