{ lib, ... }:
lib.types.submodule {
  options = {
    defer = lib.mkOption {
      type = lib.type.str;
      description = "Name of the command to defer";
    };
    silent = lib.mkOption {
      type = lib.type.nullOr lib.type.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
