{ lib, ... }:
let
  inherit (lib) types mkOption;
in
types.submodule {
  options = {
    defer = mkOption {
      type = types.str;
      description = "Name of the command to defer";
    };
    silent = mkOption {
      type = types.nullOr types.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
