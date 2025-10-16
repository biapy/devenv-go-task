/**
  # Task call schema
*/
{ lib, ... }:
let
  inherit (lib) types mkOption;
  inherit (lib.types) submodule nullOr attrsOf;
  localTypes = {
    variable = import ./variable.nix { inherit lib; };
  };
in
submodule {
  options = {
    task = mkOption {
      type = types.str;
      description = "Name of the task to run";
    };

    vars = mkOption {
      type = attrsOf localTypes.variable;
      description = "Values passed to the task called";
      default = { };
    };

    silent = mkOption {
      type = nullOr types.bool;
      description = "Hides task name and command from output. The command's output will still be redirected to `STDOUT` and `STDERR`.";
      defaultText = "false";
      default = null;
    };
  };
}
