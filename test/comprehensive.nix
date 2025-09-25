{ pkgs, lib, config, inputs, ... }:

{
  imports = [ ../default.nix ];
  
  # Comprehensive feature test
  go-task.enable = true;
  go-task.taskfile = "test/Taskfile.test.yml";
  
  go-task.settings = {
    version = "3";
    vars = {
      TEST_VAR = "test-value";
    };
    env = {
      TEST_ENV = "test-environment";
    };
    output = "group";
    silent = false;
    dotenv = [ ".env.test" ];
  };
  
  go-task.tasks = {
    # Test all task features
    full-featured-task = {
      desc = "Task demonstrating all features";
      cmds = [
        "echo 'Running full featured task'"
        "echo 'Variable: {{.TEST_VAR}}'"
        "echo 'Environment: $TASK_TEST_ENV'"
      ];
      deps = [ "dependency-task" ];
      sources = [ "test/**/*.txt" ];
      generates = [ "test/output.txt" ];
      vars = {
        TASK_VAR = "task-specific-value";
      };
      env = {
        TASK_TEST_ENV = "task-environment";
      };
      dir = "test";
      method = "checksum";
      silent = false;
      preconditions = [
        {
          sh = "test -d test";
          msg = "Test directory does not exist";
        }
        {
          sh = "echo 'precondition check'";
        }
      ];
    };
    
    dependency-task = {
      desc = "Dependency task";
      cmds = [ "echo 'Dependency executed'" ];
    };
    
    silent-task = {
      desc = "Silent task";
      cmds = [ "echo 'This should be silent'" ];
      silent = true;
    };
    
    timestamp-task = {
      desc = "Task using timestamp method";
      cmds = [ "touch test-timestamp.txt" ];
      generates = [ "test-timestamp.txt" ];
      method = "timestamp";
    };
  };
}