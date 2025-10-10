/**
  # Shell Options: set

  Available `set` options for POSIX shell features:

  - `allexport` / `a` - Export all variables
  - `errexit` / `e` - Exit on error
  - `noexec` / `n` - Read commands but don't execute
  - `noglob` / `f` - Disable pathname expansion
  - `nounset` / `u` - Error on undefined variables
  - `xtrace` / `x` - Print commands before execution
  - `pipefail` - Pipe failures propagate
*/
{ lib, ... }:
lib.types.listOf (
  lib.types.enum [
    "allexport"
    "a" # Export all variables
    "errexit"
    "e" # Exit on error
    "noexec"
    "n" # Read commands but don't execute
    "noglob"
    "f" # Disable pathname expansion
    "nounset"
    "u" # Error on undefined variables
    "xtrace"
    "x" # Print commands before execution
    "pipefail" # Pipe failures propagate
  ]
)
