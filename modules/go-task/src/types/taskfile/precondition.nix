/**
  # Precondition schema

  Conditions that must be met before running a task.
*/
{ lib, ... }:
lib.types.oneOf [
  # Simple precondition (shorthand)
  lib.types.str

  # Precondition with custom message
  (lib.types.submodule {
    options = {
      sh = lib.mkOption {
        type = lib.types.str;
        description = "Shell command";
      };

      msg = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Failed precondition message.";
        default = null;
      };
    };
  })
]
