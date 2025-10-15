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

    task = mkOption {
      type = types.str;
      description = "Task name";
    };

    vars = mkOption {
      type = types.attrsOf localTypes.variable;
      description = "Values passed to the task called";
      default = { };
    };

    silent = mkOption {
      type = types.nullOr types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };
  };
}
