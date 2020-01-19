module Nihil.Syntax.Concrete.Parser.Expression.Operator where

import Nihil.Syntax.Common (Parser)
import Nihil.Syntax.Concrete.Core
import Nihil.Syntax.Concrete.Parser (withPosition)
import Nihil.Syntax.Concrete.Parser.Identifier
import Nihil.Syntax.Concrete.Parser.Enclosed
import Nihil.Syntax.Concrete.Debug
import Control.Applicative ((<|>))

pOperator :: Parser AAtom
pOperator = debug "p[Expression]Operator" $ withPosition (AOperator <$> (pTicks (pIdentifier <|> pIdentifier') <|> pAnySymbolᵉ))