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

module Blob.Language.Syntax.Rules.Desugaring.Expression where

import Blob.Language.Syntax.Internal.Parsing.Located
import qualified Blob.Language.Syntax.Internal.Parsing.AST as P
import qualified Blob.Language.Syntax.Internal.Desugaring.CoreAST as D
import Blob.Language.Syntax.Desugarer (Desugarer)
import Blob.Language.Syntax.Rules.Desugaring.Expressions.ShuntingYard

-- | Desugars a 'P.Expr' into a 'D.Expr'.
desugarExpression :: String -> Located P.Expr -> Desugarer (Located D.Expr)
desugarExpression fileName (e :@ p) = syExpr fileName e [] []