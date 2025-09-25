{ pkgs, lib, config, inputs, ... }:

{
  imports = [ ../default.nix ];
  
  go-task.enable = true;
  go-task.taskfile = "Taskfile.yml";
  
  go-task.tasks = {
    build = {
      desc = "Build the project";
      cmds = [
        "echo 'Building project...'"
        "mkdir -p dist"
        "echo 'Build complete!'"
      ];
      sources = [ "src/**/*.go" ];
      generates = [ "dist/app" ];
    };
    
    test = {
      desc = "Run tests";
      cmds = [
        "echo 'Running tests...'"
        "go test ./..."
      ];
      deps = [ "build" ];
    };
    
    clean = {
      desc = "Clean build artifacts";
      cmds = [
        "rm -rf dist"
        "echo 'Clean complete!'"
      ];
    };
    
    dev = {
      desc = "Start development server";
      cmds = [
        "echo 'Starting development server...'"
        "go run main.go"
      ];
      deps = [ "build" ];
      vars = {
        PORT = "8080";
      };
      env = {
        GO_ENV = "development";
      };
    };
  };
  
  enterShell = ''
    echo "Welcome to the devenv-go-task example!"
    echo "Available tasks:"
    task --list
  '';
}