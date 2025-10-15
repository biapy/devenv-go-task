{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.devenv) root;
  inherit (lib) types mkOption;
  localTypes = {
    taskrc = import ./types/taskrc.nix { inherit lib; };
    taskfile = import ./types/taskfile.nix { inherit lib; };
  };
in
{
  enable = mkOption {
    type = types.bool;
    description = "Enable go-task task runner";
    default = false;
  };

  package = mkOption {
    type = types.package;
    default = pkgs.go-task;
    defaultText = lib.literalExpression "pkgs.go-task";
    description = "The go-task package to use";
  };

  taskrcPath = mkOption {
    type = types.str;
    description = "Path to taskrc file";
    defaultText = "\${DEVENV_ROOT}/.taskrc.yml";
    default = "${root}/.taskrc.yml";
  };

  taskfilePath = mkOption {
    type = types.str;
    description = "Path to the taskfile to generate";
    defaultText = "\${DEVENV_ROOT}/Taskfile.dist.yml";
    default = "${root}/Taskfile.dist.yml";
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
}
