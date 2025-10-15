/**
  # Shell Options: shopt

  Bash shell options for all commands.

  - `expand_aliases` - Enable alias expansion
  - `globstar` - Enable `**` recursive globbing
  - `nullglob` - Null glob expansion
*/
{ lib, ... }:
let
  inherit (lib.types) enum listOf;
  shoptEnum = enum [
    "expand_aliases"
    "globstar"
    "nullglob"
  ];
in
listOf shoptEnum
