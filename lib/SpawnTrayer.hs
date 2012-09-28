module SpawnTrayer
       ( spawnTrayer
       , spawnSoundApp
       ) where

import XMonad
import XMonad.Util.Run (spawnPipe, safeSpawn)

trayer   = "trayer"             :: FilePath
soundApp = "gnome-sound-applet" :: FilePath

spawnSoundApp :: MonadIO m => m ()
spawnSoundApp = safeSpawn soundApp []

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