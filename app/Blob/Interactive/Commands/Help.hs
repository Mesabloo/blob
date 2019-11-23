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

module Blob.Interactive.Commands.Help where

import Blob.Interactive.Command (CommandParser, keyword, Command(..))
import System.Console.ANSI
import Text.Megaparsec (try, hidden, (<|>), (<?>))
import qualified Text.Megaparsec.Char as C
import Data.Functor (($>))

-- | The 'Help' command parser.
--
-- Either @:h@ or @:help@ or @:?@.
help :: CommandParser Command
help = C.space *> (try . hidden) (keyword "?" <|> keyword "help" <|> keyword "h") <* C.space $> Help <?> "߷"

helpCommand :: IO ()
helpCommand = do
    let colorCommand action = do
            setSGR [SetColor Foreground Vivid Magenta, SetConsoleIntensity BoldIntensity]
            action
            setSGR [Reset]

    colorCommand (putStr "\":help\" \":h\" \":?\"")
        >> putStrLn ": show this menu."

    colorCommand (putStr "\":quit\" \":q\"")
        >> putStrLn ": exit the REPL."

    colorCommand (putStr "\":load [file]\" \":l [file]\"")
        >> putStrLn ": load a file into the REPL for further use."

    colorCommand (putStr "\":type [expr]\" \":t [expr]\"")
        >> putStrLn ": get the type of an expression."

    colorCommand (putStr "\":kind [type]\" \":k [type]\"")
        >> putStrLn ": get the kind of a type."

    colorCommand (putStr "\":reset {symbols}\" \":r {symbols}\"")
        >> putStrLn ": reset the REPL to its original state or delete some user-defined symbols."

    colorCommand (putStr "\":time [expr]\"")
        >> putStrLn ": print the execution time of an expression."

    colorCommand (putStr "\":bench [n] [expr]\"")
        >> putStrLn ": make some benchmark on an expression."

    colorCommand (putStr "\":env\"")
        >> putStrLn ": print the whole current environment"

    colorCommand (putStr "\":! [command]\"")
        >> putStrLn ": execute a shell command from the REPL"

    putStrLn "\nYou also can write some core directly inside the REPL." >> setSGR [Reset]