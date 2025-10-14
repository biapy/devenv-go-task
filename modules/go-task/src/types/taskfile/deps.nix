/**
  # Dependency schema

  Tasks to run before this task
*/
{ lib, ... }:
lib.types.oneOf [
  # Simple dependency
  lib.types.str

  # Complex Dependency
  (import ./task_call.nix)  {inherit lib;}

  (import ./for_deps_call.nix)  {inherit lib;}
]
