{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.types) attrsOf listOf oneOf;
  localTypes = {
    task = import ./task.nix { inherit lib; };
    # task_call = import ./task_call.nix { inherit lib; };
    # defer_task_call = import ./defer_task_call.nix { inherit lib; };
    # defer_cmd_call = import ./defer_cmd_call.nix { inherit lib; };
    taskList = listOf (oneOf [
      types.str
      /*
        localTypes.task_call
        localTypes.defer_task_call
        localTypes.defer_cmd_call
      */
      types.attrs
    ]);
  };
in
# String command
attrsOf (oneOf [
  types.str
  localTypes.task
  localTypes.taskList
])
