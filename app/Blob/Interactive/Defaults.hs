-- Blobc, a compiler for compiling Blob source code
-- Copyright (c) 2019 Mesabloo

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

module Blob.Interactive.Defaults where

import Blob.Prelude (initGlobalEnv, initEvalState)
import Blob.Language.Syntax.Internal.Desugaring.Defaults (initSugarState)
import Blob.Interactive.REPL (REPLState(..))
import Control.Monad.State (liftIO)
import System.Console.ANSI
import System.IO (hFlush, stdout)

-- | The default 'REPLState'.
initREPLState :: REPLState
initREPLState =
    REPLState
        initGlobalEnv
        initEvalState
        initSugarState
        "> "
        []

-- | The welcome message when starting the REPL.
initREPL :: IO ()
initREPL = liftIO $ do
        putStr ("iBlob, version " <> version <> "\t\t") >> setSGR [Reset]
        setSGR [SetConsoleIntensity BoldIntensity, SetColor Foreground Vivid Magenta] >> putStr "\":?\"" >> setSGR [Reset]
        putStrLn " for help." >> setSGR [Reset]
        hFlush stdout

-- | The current version of iBlob.
version :: String
version = "0.0.1"