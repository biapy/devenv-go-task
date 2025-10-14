{ lib, ... }:
# String command
lib.types.attrOf lib.types.oneOf [
  lib.types.str
  (import ./task.nix) {inherit lib;}
  lib.types.listOf
  lib.types.oneOf
  [
    lib.types.str
    (import ./task_call.nix) {inherit lib;}
    (import ./defer_task_call.nix) {inherit lib;}
    (import ./defer_cmd_call.nix) {inherit lib;}
  ]
]
