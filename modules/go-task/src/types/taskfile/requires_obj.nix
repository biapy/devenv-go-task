{ lib, ... }:
let
  inherit (lib) types mkOption;
  inherit (lib.types) either listOf;

  localTypes = {
    requirement = types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          description = "Required variable name";
        };

        enum = mkOption {
          type = listOf types.str;
          description = "Accepted variable values";
          default = [ ];
        };
      };
    };
  };

in
types.submodule {
  options = {
    vars = mkOption {
      description = "List of variables that must be defined for the task to run";
      type = listOf (either types.str localTypes.requirement);
      default = [ ];
    };
  };
}
