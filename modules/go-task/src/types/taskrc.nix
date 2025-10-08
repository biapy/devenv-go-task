{ lib, ... }:
let
  inherit (lib) types;
in
types.submodule {
  options = {
    verbose = lib.mkOption {
      type = types.bool;
      description = "Enable verbose output for all tasks";
      default = false;
    };

    concurrency = lib.mkOption {
      type = types.nullOr types.integer;
      description = "Number of concurrent tasks to run";
      default = null;
    };

    experiments = lib.mkOption {
      type = types.attrsOf types.integer;
      description = "Enable Task's experimental features. See https://taskfile.dev/docs/experiments/";
      default = { };
    };
  };
}
