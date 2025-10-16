/**
  # Output schema

  Output mode for parallel tasks.
*/
{ lib, ... }:
lib.types.oneOf [
  (lib.types.enum [
    "interleaved"
    "group"
    "prefixed"
  ])

  (lib.types.submodule {
    options = {
      group = lib.mkOption {
        type = lib.types.submodule {
          options = {
            begin = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              defaultText = "::group::{{.TASK}}";
              default = null;
            };
            end = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              defaultText = "::endgroup::";
              default = null;
            };
            error_only = lib.mkOption {
              type = lib.types.nullOr lib.types.bool;
              description = "Swallows command output on zero exit code";
              defaultText = "false";
              default = null;
            };
          };
        };
      };
    };
  })
]
