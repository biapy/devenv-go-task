{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.devenv) root;
in
{
  enable = lib.mkOption {
    type = lib.types.bool;
    description = "Enable go-task task runner";
    default = false;
  };

  package = lib.mkOption {
    type = lib.types.package;
    default = pkgs.go-task;
    defaultText = lib.literalExpression "pkgs.go-task";
    description = "The go-task package to use";
  };

  taskrcPath = lib.mkOption {
    type = lib.types.str;
    description = "Path to taskrc file";
    defaultText = "\${DEVENV_ROOT}/.taskrc.yml";
    default = "${root}/.taskrc.yml";
  };

  taskfilePath = lib.mkOption {
    type = lib.types.str;
    description = "Path to the taskfile to generate";
    defaultText = "\${DEVENV_ROOT}/Taskfile.dist.yml";
    default = "${root}/Taskfile.dist.yml";
  };

  taskrc = lib.mkOption {
    type = import ./types/taskrc.nix;
    description = "Task configuration, stored in '.taskrc.yml'. See https://taskfile.dev/docs/reference/config";
    default = { };
  };

  settings = lib.mkOption {
    type = import ./types/settings.nix;
    description = "Global taskfile settings";
    default = { };
  };

  tasks = lib.mkOption {
    type = import ./types/task.nix;
    description = "Task definitions";
    default = { };
  };
}
