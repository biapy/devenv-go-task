{ ... }:
{
  imports = [ ../default.nix ];

  # Minimal configuration test
  go-task.enable = true;

  go-task.tasks = {
    hello = {
      desc = "Say hello";
      cmds = [ "echo 'Hello from go-task!'" ];
    };
  };
}
