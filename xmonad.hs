{-
  XMonad configuration by laumann.
-}
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe, safeSpawn)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Actions.GridSelect
import XMonad.Prompt.Shell

import System.IO

import Data.List (intercalate)

-- Home rolled modules
import SpawnTrayer
import SysUtils
import XMobar

xmobar_bin = "/usr/bin/xmobar" :: FilePath

--xmobar_rc = "/home/thomas/.xmobarrc" :: FilePath

main = do spawnTrayer
          xmobarrc <- getXMobarRC
          xmproc <- spawnPipe $ xmobar_bin +||+ xmobarrc
          xmonad $ defaultConfig { manageHook = manageDocks <+> manageHook defaultConfig
                                 , layoutHook = avoidStruts $ layoutHook defaultConfig
                                 , logHook    = dynamicLogWithPP xmobarPP
                                                { ppOutput = hPutStrLn xmproc
                                                , ppTitle = xmobarColor "green" "" . shorten 50
                                                }
                                 , modMask    = mod4Mask -- Rebind Mod to the Win key
                              -- , borderWidth = 2
                                 } `additionalKeys`
            [ ((mod4Mask, xK_g), goToSelected defaultGSConfig)
            --, ((mod4Mask, xK_x), shellPrompt defaultConfig)
            ]

(+||+) :: String -> String -> String
s1 +||+ s2 = s1 ++ ( ' ' : s2 )
