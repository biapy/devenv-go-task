/**
  oneOf is broken for submodules.

  see [Problems with types.oneOf and submodules @ NixOS discourse](https://discourse.nixos.org/t/problems-with-types-oneof-and-submodules/15197/1).
*/
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.types) either oneOf;

  localTypes = {
    cmd_call = import ./cmd_call.nix { inherit lib; };
    task_call = import ./task_call.nix { inherit lib; };
    defer_task_call = import ./defer_task_call.nix { inherit lib; };
    defer_cmd_call = import ./defer_cmd_call.nix { inherit lib; };
    for_cmds_call = import ./for_cmds_call.nix { inherit lib; };
  };

in
oneOf [
  (either types.str localTypes.cmd_call)
  (either types.str localTypes.task_call)
  (either types.str localTypes.defer_task_call)
  (either types.str localTypes.defer_cmd_call)
  (either types.str localTypes.for_cmds_call)
]
