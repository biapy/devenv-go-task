{ lib, ... }:
lib.types.submodule {
  options = {
    for = lib.mkOption {
      type = (import ./for.nix) {inherit lib;};
      description = "loop dependency over values";
      default = null;
    };

    cmd = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Command to run";
    };

    task = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Task to run";
    };

    silent = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };

    vars = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/variable.nix)  {inherit lib;};
      description = "Values passed to the task called";
      default = { };
    };

    platforms = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Specifies which platforms the command should be run on.";
      default = [ ];
    };
  };
}
