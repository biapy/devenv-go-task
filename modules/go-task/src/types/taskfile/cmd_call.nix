/**
  # Command schema

  Individual command configuration within a task.
*/
{ lib, ... }:
lib.types.submodule {
  description = "Command configuration.";
  options = {
    cmd = lib.mkOption {
      type = lib.types.str;
      description = "Command to run";
    };
    silent = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };

    ignore_error = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      description = "Prevent command from aborting the execution of task even after receiving a status code of 1";
      defaultText = "false";
      default = null;
    };

    platforms = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Platforms where this task should run";
      default = [ ];
    };

    set = lib.mkOption {
      type = lib.types.nullOr (import ./shell-set.nix);
      description = "Enables POSIX shell options for this command. See https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html";
      default = null;
    };

    shopt = lib.mkOption {
      type = lib.types.nullOr (import ./shell-shopt.nix);
      description = "Enables Bash shell options for this command. See https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html";
      default = null;
    };
  };
}
