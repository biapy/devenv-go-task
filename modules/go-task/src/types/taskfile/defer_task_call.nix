{ lib, ... }:
lib.types.submodule {
  options = {
    defer = lib.mkOption {
      type = (import ./task_call.nix)  {inherit lib;};
      description = "Run a command when the task completes. This command will run even when the task fails";
    };
  };
}
