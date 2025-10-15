/**
  # Task call schema
*/
{ lib, ... }:
let
  inherit (lib) types mkOption;
  localTypes = {
    variable = import ./variable.nix { inherit lib; };
  };
in
types.submodule {
  options = {
    task = mkOption {
      type = types.str;
      description = "Name of the task to run";
    };

    vars = mkOption {
      type = types.attrsOf localTypes.variable;
      description = "Values passed to the task called";
      default = { };
    };

    silent = mkOption {
      type = types.nullOr types.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
