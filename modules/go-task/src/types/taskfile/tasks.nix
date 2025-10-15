{ lib, ... }:
let
  inherit (lib) types;
  localTypes = {
    task = import ./task.nix { inherit lib; };
    task_call = import ./task_call.nix { inherit lib; };
    defer_task_call = import ./defer_task_call.nix { inherit lib; };
    defer_cmd_call = import ./defer_cmd_call.nix { inherit lib; };
    taskList = types.listOf (
      types.oneOf [
        types.str
        localTypes.task_call
        localTypes.defer_task_call
        localTypes.defer_cmd_call
      ]
    );
  };
in
# String command
types.attrsOf (
  types.oneOf [
    types.str
    localTypes.task
    localTypes.taskList
  ]
)
