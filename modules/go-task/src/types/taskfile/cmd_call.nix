/**
  # Command schema

  Individual command configuration within a task.
*/
{ lib, ... }:
let
  inherit (lib) types mkOption;
  localTypes = {
    shell-set = import ./shell-set.nix { inherit lib; };
    shell-shopt = import ./shell-shopt.nix { inherit lib; };
  };
in
types.submodule {
  options = {
    cmd = mkOption {
      type = types.str;
      description = "Command to run";
    };
    silent = mkOption {
      type = types.nullOr types.bool;
      description = "Silent mode disables echoing of command before Task runs it";
      defaultText = "false";
      default = null;
    };

    ignore_error = mkOption {
      type = types.nullOr types.bool;
      description = "Prevent command from aborting the execution of task even after receiving a status code of 1";
      defaultText = "false";
      default = null;
    };

    platforms = mkOption {
      type = types.listOf types.str;
      description = "Platforms where this task should run";
      default = [ ];
    };

    set = mkOption {
      type = types.nullOr localTypes.shell-set;
      description = "Enables POSIX shell options for this command. See https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html";
      default = null;
    };

    shopt = mkOption {
      type = types.nullOr localTypes.shell-opt;
      description = "Enables Bash shell options for this command. See https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html";
      default = null;
    };
  };
}
