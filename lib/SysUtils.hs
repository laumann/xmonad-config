
-- | System specific utility functions
module SysUtils where

import XMonad hiding (kill)
import XMonad.Util.Run (safeSpawn)

-- killPanels :: MonadIO m => m ()
-- killPanels = do killall trayer

kill :: MonadIO m => FilePath -> m ()
kill prog = safeSpawn "killall" [prog]

-- | Invoke kill all the listed programs.
killall :: MonadIO m => [FilePath] -> m ()
killall progs = mapM_ kill progs