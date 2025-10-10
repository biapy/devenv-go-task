/**
  # Shell Options: shopt

  Bash shell options for all commands.

  - `expand_aliases` - Enable alias expansion
  - `globstar` - Enable `**` recursive globbing
  - `nullglob` - Null glob expansion
*/
{ lib, ... }:
lib.types.listOf (
  lib.types.enum [
    "expand_aliases"
    "globstar"
    "nullglob"
  ]
)
