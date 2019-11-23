module Blob.Language.PrettyPrinting.Kinds where

import Blob.Language.PrettyPrinting.Pretty
import Blob.Language.TypeChecking.Internal.Kind
import Text.PrettyPrint.Leijen hiding (Pretty, pretty)

instance Pretty Kind where
    -- | Kind pretty printing
    pretty (KVar (KV id')) = text id'
    pretty KType           = text "*"
    pretty (KArr k1 k2)    = parenthesizeIfNeeded k1 <+> text "->" <+> pretty k2
      where
        parenthesizeIfNeeded k = case k of
            KArr _ _ -> parens $ pretty k
            _        -> pretty k