{ lib, pkgs, ... }:
let
  inherit (lib) types mkOption;
  inherit (pkgs) go-task;
  localTypes = {
    taskrc = import ./types/taskrc.nix { inherit lib; };
    taskfile = import ./types/taskfile.nix { inherit lib; };
  };
in
{
  options.biapy.go-task = {
    enable = mkOption {
      type = types.bool;
      description = "Enable go-task task runner";
      default = false;
    };

    package = mkOption {
      type = types.package;
      default = go-task;
      defaultText = lib.literalExpression "pkgs.go-task";
      description = "The go-task package to use";
    };

    taskrcPath = mkOption {
      type = types.str;
      description = "Path to taskrc file";
      defaultText = "\${DEVENV_ROOT}/.taskrc.yml";
      default = ".taskrc.yml";
    };

    taskfilePath = mkOption {
      type = types.str;
      description = "Path to the taskfile to generate";
      defaultText = "\${DEVENV_ROOT}/Taskfile.dist.yml";
      default = "Taskfile.dist.yml";
    };

    taskrc = mkOption {
      type = localTypes.taskrc;
      description = "Task configuration, stored in '.taskrc.yml'. See https://taskfile.dev/docs/reference/config";
      default = { };
    };

    taskfile = mkOption {
      type = localTypes.taskfile;
      description = "Task Taskfile, stored in 'Taskfile.dist.yml'. See https://taskfile.dev/docs/reference/schema";
      default = { };
    };

    prefixed-tasks = mkOption {
      description = "Enable tasks running tasks with the same prefix (`ci:format`, `ci:lint`, …).";
      type = types.submodule {
        options = {
          enable = mkOption {
            type = types.bool;
            description = "Enable prefixed tasks support";
            default = true;
          };

          separator = mkOption {
            type = types.str;
            description = "Prefix separator";
            default = ":";
          };
        };
      };
      default = { };
    };
  };
}
