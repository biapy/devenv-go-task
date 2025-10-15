{ lib, ... }:
let
  inherit (lib) types mkOption;
in
types.submodule {
  options = {
    verbose = mkOption {
      type = types.bool;
      description = "Enable verbose output for all tasks";
      default = false;
    };

    concurrency = mkOption {
      type = types.nullOr types.integer;
      description = "Number of concurrent tasks to run";
      default = null;
    };

    experiments = mkOption {
      type = types.nullOr (types.attrsOf types.integer);
      description = "Enable Task's experimental features. See https://taskfile.dev/docs/experiments/";
      default = null;
    };
  };
}
