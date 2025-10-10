/**
  # Task call schema
*/
{ lib, ... }:
lib.types.submodule {
  options = {
    task = lib.mkOption {
      type = lib.types.str;
      description = "Name of the task to run";
    };

    vars = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/variable.nix);
      description = "Values passed to the task called";
      default = { };
    };

    silent = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
