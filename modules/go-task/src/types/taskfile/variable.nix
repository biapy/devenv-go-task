/**
  # Variable schema

  Variables support multiple types and can be static values,
  dynamic commands, references, or maps.
*/
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.types)
    nullOr
    listOf
    oneOf
    ;

  /*
    inherit (lib) types mkOption;
    inherit (lib.types) submodule;

    localTypes = {
      # Dynamic Variables (sh)
      dynamicVariable = submodule {
        description = "The value will be treated as a command and the output assigned to the variable";
        options = {
          sh = mkOption {
            type = types.str;
            description = "Command to initialize the variable value";
            defaultText = ''date -u +"%Y-%m-%dT%H:%M:%SZ"'';
          };
        };
      };

      # Variable References (ref)
      variableReference = submodule {
        description = "The value will be used to lookup the value of another variable which will then be assigned to this variable";
        options = {
          ref = mkOption {
            type = types.str;
            description = "Variable name";
            defaultText = "BASE_VERSION";
          };
        };
      };

      # Map Variables (map)
      mapVariable = submodule {
        description = "The value will be treated as a literal map type and stored in the variable";
        options = {
          map = mkOption { type = types.attrs; };
        };
      };
    };
  */
in
nullOr (oneOf [
  # Static Variables
  types.str
  types.bool
  types.str
  types.int
  (listOf types.str)
  # localTypes.dynamicVariable
  # localTypes.variableReference
  # localTypes.mapVariable
  types.attrs
])
