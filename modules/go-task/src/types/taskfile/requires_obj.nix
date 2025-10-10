{ lib, ... }:
lib.types.submodule {
  description = "Required variables with optional enums.";
  options = {
    vars = lib.mkOption {
      description = "List of variables that must be defined for the task to run";
      type = lib.types.listOf lib.types.oneOf [
        lib.types.str
        lib.types.submodule
        {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Required variable name";

            };

            enum = lib.mkOption {
              type = lib.type.nullOr lib.types.listOf lib.types.str;
              description = "Accepted variable values";
              default = null;
            };
          };
        }
      ];
    };
  };
}
