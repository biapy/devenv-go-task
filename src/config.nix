{ config, lib, ... }:
let
  cfg = config.go-task;

  # Convert preconditions to YAML format
  preconditionToYaml =
    precond:
    {
      sh = precond.sh;
    }
    // lib.optionalAttrs (precond.msg != null) {
      msg = precond.msg;
    };

  # Convert task configuration to YAML format
  taskToYaml = name: task: {
    ${name} = lib.filterAttrs (n: v: v != null && v != [ ] && v != { } && v != false) {
      desc = task.desc;
      cmds = if task.cmds != [ ] then task.cmds else null;
      deps = if task.deps != [ ] then task.deps else null;
      sources = if task.sources != [ ] then task.sources else null;
      generates = if task.generates != [ ] then task.generates else null;
      vars = if task.vars != { } then task.vars else null;
      env = if task.env != { } then task.env else null;
      silent = if task.silent then true else null;
      method = task.method;
      dir = task.dir;
      preconditions =
        if task.preconditions != [ ] then (map preconditionToYaml task.preconditions) else null;
    };
  };

  # Generate the complete taskfile content
  taskfileContent = lib.filterAttrs (n: v: v != null && v != [ ] && v != { } && v != false) {
    version = cfg.settings.version;
    vars = if cfg.settings.vars != { } then cfg.settings.vars else null;
    env = if cfg.settings.env != { } then cfg.settings.env else null;
    dotenv = if cfg.settings.dotenv != [ ] then cfg.settings.dotenv else null;
    output = cfg.settings.output;
    silent = if cfg.settings.silent then true else null;
    tasks = lib.foldl' (acc: name: acc // (taskToYaml name cfg.tasks.${name})) { } (
      lib.attrNames cfg.tasks
    );
  };

  # Convert to YAML string
  yamlContent = lib.generators.toYAML { } taskfileContent;

  # Create the taskfile
  taskfileFile = pkgs.writeText "taskfile" yamlContent;
in
lib.mkIf cfg.enable {
  packages = [ cfg.package ];

  enterShell = lib.mkAfter ''
    # Copy the generated taskfile to the project directory
    if [ ! -z "${cfg.taskfile}" ] && [ -n "${toString (lib.attrNames cfg.tasks)}" ]; then
      cp ${taskfileFile} "${cfg.taskfile}"
      echo "Generated ${cfg.taskfile} with ${toString (lib.length (lib.attrNames cfg.tasks))} tasks"
    fi
  '';
}
