{ lib, ... }:
# String command
lib.types.attrOf lib.types.oneOf [
  lib.types.str
  import
  ./task.nix
  lib.types.listOf
  lib.types.oneOf
  [
    lib.types.str
    import
    ./task_call.nix
    import
    ./defer_task_call.nix
    import
    ./defer_cmd_call.nix
  ]
]
