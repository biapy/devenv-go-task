{ lib, ... }:
let
  inherit (lib) types mkOption;
  localTypes = {
    task_call = import ./task_call.nix { inherit lib; };
  };
in
types.submodule {
  options = {
    defer = mkOption {
      type = localTypes.task_call;
      description = "Run a command when the task completes. This command will run even when the task fails";
    };
  };
}
