{ config, lib, ... }:
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

  taskfile = lib.mkOption {
    type = lib.types.str;
    description = "Path to the taskfile to generate";
    defaultText = "${DEVENV_ROOT}/Taskfile.dist.yml";
    default = "${root}/Taskfile.dist.yml";
  };

  settings = lib.mkOption {
    type = (import ./types/settings.nix);
    description = "Global taskfile settings";
    default = { };
  };

  tasks = lib.mkOption {
    type = (import ./types/task.nix);
    description = "Task definitions";
    default = { };
  };
}
