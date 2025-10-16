{ lib, ... }:
let
  inherit (lib) types mkOption;
  inherit (lib.types)
    attrsOf
    listOf
    nullOr
    oneOf
    submodule
    ;
  localTypes = {
    duration = types.strMatching "^[0-9]+(?:m|s|ms)$";
    include = import ./taskfile/include.nix { inherit lib; };
    variable = import ./taskfile/variable.nix { inherit lib; };
    output = import ./taskfile/output.nix { inherit lib; };
    tasks = import ./taskfile/tasks.nix { inherit lib; };
    shell-set = import ./taskfile/shell-set.nix { inherit lib; };
    shell-shopt = import ./taskfile/shell-shopt.nix { inherit lib; };
  };
in
submodule {
  options = {

    version = mkOption {
      type = oneOf [
        types.str
        types.int
      ];
      description = "Taskfile version";
      default = "3";
    };

    output = mkOption {
      type = nullOr localTypes.output;
      description = "Output mode for parallel tasks";
      defaultText = "interleaved";
      default = null;
    };

    method = mkOption {
      type = nullOr (
        types.enum [
          "checksum"
          "timestamp"
          "none"
        ]
      );
      description = "Default method for checking if tasks are up-to-date";
      defaultText = "checksum";
      default = null;
    };

    includes = mkOption {
      type = attrsOf localTypes.include;
      description = "Include other Taskfiles";
      default = { };
    };

    vars = mkOption {
      type = attrsOf localTypes.variable;
      description = "Global variables";
      default = { };
    };

    env = mkOption {
      type = attrsOf localTypes.variable;
      description = "Global environment variables";
      default = { };
    };

    tasks = mkOption {
      type = localTypes.tasks;
      description = "Task definitions";
      default = {
        list = {
          desc = "List available tasks";
          cmds = [ "task --list" ];
          aliases = [ "default" ];
          silent = true;
        };
      };
    };

    silent = mkOption {
      type = nullOr types.bool;
      description = "Global silent mode";
      defaultText = "false";
      default = null;
    };

    dotenv = mkOption {
      type = listOf types.str;
      description = "Dotenv files to load";
      default = [ ];
    };

    run = mkOption {
      type = nullOr (
        types.enum [
          "always"
          "once"
          "when_changed"
        ]
      );
      description = "Default execution behavior for tasks";
      defaultText = "always";
      default = null;

    };

    interval = mkOption {
      type = nullOr localTypes.duration;
      description = "Watch interval for file changes";
      defaultText = "100ms";
      default = null;

    };

    set = mkOption {
      type = localTypes.shell-set;
      description = "POSIX shell options for all commands";
      default = [ ];
    };

    shopt = mkOption {
      type = localTypes.shell-shopt;
      description = "Bash shell options for all commands";
      default = [ ];
    };

  };
}
