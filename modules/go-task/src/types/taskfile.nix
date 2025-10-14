{ lib, ... }:
lib.types.submodule {
  options = {

    version = lib.mkOption {
      type = lib.types.oneOf [
        lib.types.str
        lib.types.int
      ];
      description = "Taskfile version";
      default = "3";
    };

    output = lib.mkOption {
      type = lib.types.nullOr (import ./taskfile/output.nix) {inherit lib;};
      description = "Output mode for parallel tasks";
      defaultText = "interleaved";
      default = null;
    };

    method = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "checksum"
          "timestamp"
          "none"
        ]
      );
      description = "Default method for checking if tasks are up-to-date";
      defaultText = "checksum";
      default = null;
    };

    includes = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/include.nix) {inherit lib;};
      description = "Include other Taskfiles";
      default = { };
    };

    vars = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/variable.nix) {inherit lib;};
      description = "Global variables";
      default = { };
    };

    env = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/variable.nix) {inherit lib;};
      description = "Global environment variables";
      default = { };
    };

    tasks = lib.mkOption {
      type = lib.types.attrsOf (import ./taskfile/task.nix) {inherit lib;};
      description = "Task definitions";
      default = { };
    };

    silent = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Global silent mode";
      defaultText = "false";
      default = null;
    };

    dotenv = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Dotenv files to load";
      default = [ ];
    };

    run = lib.mkOption {
      type = lib.types.nullOr lib.types.enum [
        "always"
        "once"
        "when_changed"
      ];
      description = "Default execution behavior for tasks";
      defaultText = "always";
      default = null;

    };

    interval = lib.mkOption {
      type = lib.types.nullOr lib.types.strMatching "^[0-9]+(?:m|s|ms)$";
      description = "Watch interval for file changes";
      defaultText = "100ms";
      default = null;

    };

    set = lib.mkOption {
      type = lib.types.nullOr (import ./taskfile/shell-set.nix);
      description = "POSIX shell options for all commands";
      default = null;
    };

    shopt = lib.mkOption {
      type = lib.types.nullOr (import ./taskfile/shell-shopt.nix);
      description = "Bash shell options for all commands";
      default = null;
    };

  };
}
