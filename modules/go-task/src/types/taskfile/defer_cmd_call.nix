{ lib, ... }:
let
  inherit (lib) types mkOption;
  inherit (lib.types) nullOr;
in
types.submodule {
  options = {
    defer = mkOption {
      type = types.str;
      description = "Run a command when the task completes. This command will run even when the task fails";
    };
    silent = mkOption {
      type = nullOr types.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
