{ ... }:
{
  imports = [ ../modules/go-task/devenv.nix ];

  # Minimal configuration test
  biapy.go-task.enable = true;

  biapy.go-task.taskfile.tasks = {
    hello = {
      desc = "Say hello";
      cmds = [ "echo 'Hello from go-task!'" ];
    };
  };
}
