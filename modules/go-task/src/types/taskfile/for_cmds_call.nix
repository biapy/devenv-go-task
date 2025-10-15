{ lib, ... }:
let
  inherit (lib) types mkOption;
  localTypes = {
    for = import ./for.nix { inherit lib; };
    variable = import ./variable.nix { inherit lib; };
  };
in
types.submodule {
  options = {
    for = mkOption {
      type = localTypes.for;
      description = "loop dependency over values";
      default = null;
    };

    cmd = mkOption {
      type = types.nullOr types.str;
      description = "Command to run";
    };

    task = mkOption {
      type = types.nullOr types.str;
      description = "Task to run";
    };

    silent = mkOption {
      type = types.nullOr types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };

    vars = mkOption {
      type = types.attrsOf localTypes.variable;
      description = "Values passed to the task called";
      default = { };
    };

    platforms = mkOption {
      type = types.listOf types.str;
      description = "Specifies which platforms the command should be run on.";
      default = [ ];
    };
  };
}
