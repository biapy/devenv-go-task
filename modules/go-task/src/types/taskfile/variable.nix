/**
  # Variable schema

  Variables support multiple types and can be static values,
  dynamic commands, references, or maps.
*/
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    submodule
    nullOr
    listOf
    oneOf
    either
    ;

  localTypes = {
    # Dynamic Variables (sh)
    dynamicVariable = submodule {
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
      options = {
        ref = mkOption {
          type = types.str;
          description = "Variable name. The value will be used to lookup the value of another variable which will then be assigned to this variable";
          defaultText = "BASE_VERSION";
        };
      };
    };

    # Map Variables (map)
    mapVariable = submodule {
      options = {
        map = mkOption {
          type = types.attrs;
          description = "The value will be treated as a literal map type and stored in the variable";
        };
      };
    };
  };

in
nullOr (oneOf [
  # Static Variables
  (either types.bool localTypes.dynamicVariable)
  (either types.str localTypes.variableReference)
  (either types.int localTypes.mapVariable)
  (listOf types.str)
])
