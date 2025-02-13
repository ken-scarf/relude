{-# LANGUAGE Safe #-}

{- |
Module                  : Relude.Applicative
Copyright               : (c) 2016 Stephen Diehl
                          (c) 2016-2018 Serokell
                          (c) 2018-2022 Kowainik
SPDX-License-Identifier : MIT
Maintainer              : Kowainik <xrom.xkov@gmail.com>
Stability               : Stable
Portability             : Portable

This module contains reexports of 'Applicative' and related functional.
Additionally, it provides convenient combinators to work with 'Applicative'.
-}

module Relude.Applicative
    ( -- * Reexports
      -- $reexports
      Alternative (..)
    , Applicative (..)
    , Const (..)
    , ZipList (..)
    , liftA3
    , optional
    , (<**>)

      -- * Combinators
    , pass
    , appliedTo
    ) where

import Control.Applicative (Alternative (..), Applicative (..), Const (..), ZipList (..), liftA2,
                            liftA3, optional, (<**>))


-- $setup
-- >>> import Relude
-- >>> import Relude.Monad (Maybe)

{- | Shorter alias for @pure ()@.

>>> pass :: Maybe ()
Just ()

Useful shortcut when need an empty action:

@
printJust :: Maybe Int -> IO ()
printJust mInt = case mInt of
    Just i -> putStrLn $ "Number: " ++ show i
    Nothing -> pass
@
-}
pass :: Applicative f => f ()
pass = pure ()
{-# INLINE pass #-}

{- | Named version of the '<**>' operator, which is '<*>' but flipped. It is
helpful for chaining applicative operations in forward applications using
'Relude.Function.&'.

>>> Just (+ 1) & appliedTo (Just 2)
Just 3
>>> Just (+) & appliedTo (Just 1) & appliedTo (Just 2)
Just 3
>>> Nothing & appliedTo (Just 2)
Nothing

@since 0.5.0
-}
appliedTo :: Applicative f => f a -> f (a -> b) -> f b
appliedTo = (<**>)
{-# INLINE appliedTo #-}

{- $reexports
Main data types and functions reexported from "Control.Applicative".
-}
