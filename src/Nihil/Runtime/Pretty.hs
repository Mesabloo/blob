module Nihil.Runtime.Pretty
( -- * Re-exports
  putDoc
) where

import Nihil.Runtime.Core
import Text.PrettyPrint.ANSI.Leijen
import Prelude hiding ((<$>))
import qualified Data.Map as Map

instance Pretty Value where
    pretty (VInteger i)           = integer i
    pretty (VDouble d)            = double d
    pretty (VCharacter c)         = text (show c)
    pretty (VId name)             = text name
    pretty (VTuple vs)            = tupled (fmap pretty vs)
    pretty (VConstructor name es) = text name <+> sep (fmap prettyᵛ es)
      where prettyᵛ v@(VConstructor _ []) = pretty v
            prettyᵛ v@VConstructor{}      = parens (pretty v)
            prettyᵛ v                     = pretty v
    pretty (VRecord keys)         = semiBraces (Map.elems (Map.mapWithKey (\k v -> text k <+> equals <+> pretty v) keys))
    pretty _                      = empty
