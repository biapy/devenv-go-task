/**
  # Dependency schema

  Tasks to run before this task
*/
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.types) either oneOf;

  localTypes = {
    task_call = import ./task_call.nix { inherit lib; };
    for_deps_call = import ./for_deps_call.nix { inherit lib; };
  };
in
oneOf [
  (either types.str localTypes.task_call)
  (either types.str localTypes.task_call)
]
