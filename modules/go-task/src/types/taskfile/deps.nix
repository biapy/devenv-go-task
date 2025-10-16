/**
  # Dependency schema

  Tasks to run before this task
*/
{ lib, ... }:
let
  inherit (lib) types;
  /*
    localTypes = {
      task_call = import ./task_call.nix { inherit lib; };
      for_deps_call = import ./for_deps_call.nix { inherit lib; };
    };
  */
in
types.oneOf [
  types.str
  /*
    localTypes.task_call
    localTypes.for_deps_call
  */
  types.attrs
]
