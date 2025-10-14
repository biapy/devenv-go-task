{ lib, ... }:
lib.types.oneOf [
  lib.types.str
  (import ./cmd_call.nix) {inherit lib;}
  (import ./task_call.nix) {inherit lib;}
  (import ./defer_task_call.nix) {inherit lib;}
  (import ./defer_cmd_call.nix) {inherit lib;}
  (import ./for_cmds_call.nix) {inherit lib;}
]
