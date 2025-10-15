{ lib, ... }:
let
  inherit (lib) types mkOption;

  localTypes = {
    requirement = types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          description = "Required variable name";

        };

        enum = mkOption {
          type = types.nullOr (types.listOf types.str);
          description = "Accepted variable values";
          default = null;
        };
      };
    };
  };

in
types.submodule {
  options = {
    vars = mkOption {
      description = "List of variables that must be defined for the task to run";
      type = types.listOf (
        types.oneOf [
          types.str
          localTypes.requirement
        ]
      );
      default = [ ];
    };
  };
}
