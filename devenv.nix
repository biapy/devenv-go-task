_: {
  # https://devenv.sh/basics/
  name = "Taskfile (go-task) devenv module";

  biapy.go-task.enable = true;
  biapy-recipes = {
    git.enable = true;
    nix.enable = true;
    markdown.enable = true;
    shell.enable = true;
    secrets.gitleaks.enable = true;
  };

  # https://devenv.sh/packages/
  # packages = [ ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/

  # https://devenv.sh/basics/
  # enterShell = '''';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  # enterTest = ''
  #  echo "Running tests"
  #'';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
