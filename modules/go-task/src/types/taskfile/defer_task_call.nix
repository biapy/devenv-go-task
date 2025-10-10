{ lib, ... }:
lib.types.submodule {
  options = {
    defer = lib.mkOption {
      type = import ./task_call.nix;
      description = "Run a command when the task completes. This command will run even when the task fails";
    };
  };
}
