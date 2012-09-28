module SpawnTrayer (spawnTrayer) where

import XMonad
import XMonad.Util.Run (spawnPipe, safeSpawn)

trayer = "trayer" :: FilePath

spawnTrayer :: MonadIO m => m ()
spawnTrayer = safeSpawn trayer args
  where args = [ "--edge", "top"
               , "--align", "right"
               , "--widthtype", "pixel"
               , "--width", "150"
               , "--heighttype", "pixel"
               , "--height", "15"
               , "--alpha", "150"
               , "--transparent", "true"
               , "--tint", "0x0000ff"
               , "--SetDockType", "true"
               , "--expand", "true"
             --, "--SetPartialStrut", "true"                                   
               ]