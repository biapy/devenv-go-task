/**
  # Variable schema

  Variables support multiple types and can be static values,
  dynamic commands, references, or maps.
*/
{ lib, ... }:
lib.types.nullOr lib.types.oneOf [
  # Static Variables
  lib.types.str
  lib.types.bool
  lib.types.str
  lib.types.int
  lib.types.listOf
  lib.types.str

  # Dynamic Variables (sh)
  lib.types.submodule
  {
    description = "The value will be treated as a command and the output assigned to the variable";
    options = {
      sh = lib.mkOption {
        type = lib.types.str;
        description = "Command to initialize the variable value";
        defaultText = ''date -u +"%Y-%m-%dT%H:%M:%SZ"'';
      };
    };
  }

  # Variable References (ref)
  lib.types.submodule
  {
    description = "The value will be used to lookup the value of another variable which will then be assigned to this variable";
    options = {
      ref = lib.mkOption {
        type = lib.types.str;
        description = "Variable name";
        defaultText = "BASE_VERSION";
      };
    };
  }

  # Map Variables (map)
  lib.types.submodule
  {
    description = "The value will be treated as a literal map type and stored in the variable";
    options = {
      map = lib.mkOption { type = lib.types.attrs; };
    };
  }
]
