{ lib, ... }:
lib.types.oneOf [
  lib.types.str
  (import ./cmd_call.nix)
  (import ./task_call.nix)
  (import ./defer_task_call.nix)
  (import ./defer_cmd_call.nix)
  (import ./for_cmds_call.nix)
]
