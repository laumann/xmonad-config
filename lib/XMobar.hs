-------------------------------------------------------------------------------
-- |
-- Module : XMobar
-- Copyright   :  (c) Thomas Jespersen 2012
-- License     :  as-is
--
-- Maintainer  :  laumann.thomas@gmail.com
-- Stability   :  unstable
-- Portability :  unportable
--
-- Keep the xmobar configuration in here, since it's not possible to
-- keep comments in .xmobarrc. The purpose of this module is to
-- eliminate tedious maintenance of the xmobar configuration. It
-- checks whether there exists a file called '$HOME/.xmobarrc' and,
-- if not, creates one using the default configuration.
--
-------------------------------------------------------------------------------
module XMobar
       ( getXMobarRC
       ) where

import System.Directory --(getHomeDirectory)
import System.FilePath.Posix
import Data.List (intercalate)

-- | Constants
xmobarrc = ".xmobarrc" :: String

data Config = Config [Option]
data Option = Opt String String
            | OptEnum String String
            | OptList String [String]

instance Show Config where
  show (Config options) = concat ["Config { ", fmt options, "\n       }\n"]
    where fmt options = intercalate "\n       , " $ map show options

instance Show Option where
  show (Opt key value) = concat [key, " = ", show value]
  show (OptEnum key value) = concat [key, " = ", value]
  show (OptList key values) = concat [key, " = ", fmt ((length key) + 12) values ]
    where fmt indent values = concat ["[ ", intercalate sep $ values, end]
            where space = replicate indent ' '
                  sep   = concat ["\n", space, ", "]
                  end   = concat ["\n", space, "]"]

defaultXMobarRC :: Config
defaultXMobarRC = Config $
                  [ Opt "font" "-*-Fixed-Bold-R-Normal-*-12-*-*-*-*-*-*-*"
                  , Opt "bgColor" "black"
                  , Opt "fgColor" "grey"
                  , OptEnum "position" "Top L 90"
                  , OptEnum "lowerOnStart" $ show True
                  , OptList "commands" [ "Run Swap [] 10"
                                       , "Run Memory [\"-t\", \"Mem: <usedratio>%\" 10]"
                                       , "Run Date \"%a %b %_d %l:%M\" \"date\" 10"
                                       , "Run Battery [] 10"
                                       , "Run Wireless \"wlan0\" [] 10"
                                       , "Run StdinReader"
                                       ]
                  , Opt "sepChar" "%"
                  , Opt "alignSep" "}{"
                  , Opt "template" "%StdinReader% }{ %wlan0wi% | %cpu% | %memory% * %swap% <fc=#ee9a00>%date%</fc> | %battery%"
                  ]

-- | Return a string representation of an xmobar configuration that can be written to a file.
printConfig conf = putStr $ show conf

getXMobarRC :: IO FilePath
getXMobarRC = getHomeDirectory >>= (\h -> return $ h </> xmobarrc)
