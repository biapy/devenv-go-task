/**
  # Include schema

  Configuration for including external Taskfiles.
*/
{ lib, ... }:
let
  inherit (lib) types mkOption;
  localTypes = {
    variable = import ./variable.nix { inherit lib; };
  };
in
types.oneOf [
  # Path to the Taskfile or directory to include
  types.str

  types.submodule
  {
    options = {
      taskfile = mkOption {
        type = types.str;
        description = "Path to the Taskfile or directory to include";
      };

      dir = mkOption {
        type = types.nullOr types.str;
        description = "Working directory for included tasks";
        default = null;
      };

      optional = mkOption {
        type = types.nullOr types.bool;
        description = "Don't error if the included file doesn't exist";
        defaultText = "false";
        default = null;
      };

      flatten = mkOption {
        type = types.nullOr types.bool;
        description = "Include tasks without namespace prefix";
        defaultText = "false";
        default = null;
      };

      internal = mkOption {
        type = types.nullOr types.bool;
        description = "Hide included tasks from command line and `--list`";
        defaultText = "false";
        default = null;
      };

      aliases = mkOption {
        type = types.listOf types.str;
        description = "Alternative names for the namespace";
        default = [ ];
      };

      excludes = mkOption {
        type = types.listOf types.str;
        description = "Tasks to exclude from inclusion";
        default = [ ];
      };

      vars = mkOption {
        type = types.attrsOf localTypes.variable;
        description = "Variables to pass to the included Taskfile";
        default = { };
      };

      checksum = mkOption {
        type = types.nullOr types.str;
        description = "Expected checksum of the included file";
        default = null;
      };
    };
  }
]
