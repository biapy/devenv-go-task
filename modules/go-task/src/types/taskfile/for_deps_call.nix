{ lib, ... }:
lib.types.submodule {
  options = {
    for = lib.mkOption {
      type = (import ./for.nix) {inherit lib;};
      description = "loop dependency over values";
      default = null;
    };

    task = lib.mkOption {
      type = lib.types.str;
      description = "Task name";
    };

    vars = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/variable.nix) {inherit lib;};
      description = "Values passed to the task called";
      default = { };
    };

    silent = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };
  };
}
