{ lib, ... }:
lib.types.submodule {
  options = {
    version = lib.mkOption {
      type = lib.types.str;
      description = "Taskfile version";
      default = "3";
    };

    vars = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "Global variables";
      default = { };
    };

    env = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "Global environment variables";
      default = { };
    };

    dotenv = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Dotenv files to load";
      default = [ ];
    };

    output = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "interleaved"
          "group"
          "prefixed"
        ]
      );
      description = "Output mode for parallel tasks";
      default = null;
    };

    silent = lib.mkOption {
      type = lib.types.bool;
      description = "Global silent mode";
      default = false;
    };

    shopt = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.listOf (
          lib.types.enum [
            "expand_aliases"
            "globstar"
            "nullglob"
          ]
        )
      );
      description = "Bash shell options for all commands";
      default = null;
    };
  };
}
