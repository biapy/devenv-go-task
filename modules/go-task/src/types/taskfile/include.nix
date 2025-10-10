/**
  # Include schema

  Configuration for including external Taskfiles.
*/
{ lib, ... }:
lib.types.oneOf [
  # Path to the Taskfile or directory to include
  lib.types.str

  lib.types.submodule
  {
    description = "Configuration for including external Taskfiles.";
    options = {
      taskfile = lib.mkOption {
        type = lib.types.str;
        description = "Path to the Taskfile or directory to include";
      };

      dir = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Working directory for included tasks";
        default = null;
      };

      optional = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        description = "Don't error if the included file doesn't exist";
        defaultText = "false";
        default = null;
      };

      flatten = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        description = "Include tasks without namespace prefix";
        defaultText = "false";
        default = null;
      };

      internal = lib.mkOption {
        type = lib.types.nullOr lib.types.bool;
        description = "Hide included tasks from command line and `--list`";
        defaultText = "false";
        default = null;
      };

      aliases = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Alternative names for the namespace";
        default = [ ];
      };

      excludes = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Tasks to exclude from inclusion";
        default = [ ];
      };

      vars = lib.mkOption {
        type = lib.types.attrsOf (import ./variable.nix);
        description = "Variables to pass to the included Taskfile";
        default = { };
      };

      checksum = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Expected checksum of the included file";
        default = null;
      };
    };
  }
]
