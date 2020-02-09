{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Nihil.Syntax.Concrete.Parser.Expression where

import Nihil.Syntax.Common (Parser)
import Nihil.Syntax.Concrete.Core
import Nihil.Syntax.Concrete.Parser
import Nihil.Syntax.Concrete.Parser.Identifier (pSymbol')
import Nihil.Syntax.Concrete.Parser.Expression.Atom
import Nihil.Syntax.Concrete.Parser.Expression.Where
import Nihil.Syntax.Concrete.Parser.Type
import Nihil.Utils.Source
import Nihil.Syntax.Concrete.Debug
import qualified Text.Megaparsec as MP

pExpression :: Parser AExpr
pExpression = debug "pExpression" $ do
    lineFold \s -> do
        atoms <- withPosition ((:) <$> pAtom <*> MP.many (MP.try (s *> pAtom))))
        typed <- MP.optional (typeAnnotation s)
        whereB <- MP.optional (s *> pWhere)

        let annotate t = locate [locate (ATypeAnnotated atoms t) NoSource] NoSource
        let expr = maybe atoms annotate typed
            where' ss = [locate [locate (AWhere expr ss) NoSource] NoSource]
        pure (maybe expr where' whereB)
  where typeAnnotation sp = debug "pTypeAnnotation" $ MP.try sp *> pSymbol' ":" *> MP.try sp *> pType