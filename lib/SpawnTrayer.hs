module SpawnTrayer
       ( spawnTrayer
       , spawnTrayerApps
       ) where

import XMonad
import XMonad.Util.Run (spawnPipe, safeSpawn, safeSpawnProg)

trayer   = "trayer"             :: FilePath
soundApp = "gnome-sound-applet" :: FilePath
nmapplet = "nm-applet"          :: FilePath

spawnManyProg :: MonadIO m => [FilePath] -> m ()
spawnManyProg = mapM_ safeSpawnProg

spawnTrayerApps :: MonadIO m => m ()
spawnTrayerApps = spawnManyProg [ soundApp
                                , nmapplet
                                ]


spawnTrayer :: MonadIO m => m ()
spawnTrayer = safeSpawn trayer args
  where args = [ "--edge", "top"
               , "--align", "right"
               , "--widthtype", "pixel"
               , "--width", "150"
               , "--heighttype", "pixel"
               , "--height", "14"
               , "--alpha", "150"
               , "--transparent", "true"
               , "--tint", "0x000000"
               , "--SetDockType", "true"
               , "--expand", "true"
               ]