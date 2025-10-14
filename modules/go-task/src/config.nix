{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.biapy.go-task;

  # Convert preconditions to YAML format
  preconditionToYaml =
    precond:
    { inherit (precond) sh; } // lib.optionalAttrs (precond.msg != null) { inherit (precond) msg; };


  # Convert to YAML string
  yamlContent = lib.generators.toYAML { } cfg.taskfile;

  # Create the taskfile
  taskfileFile = pkgs.writeText "taskfile" yamlContent;
in
lib.mkIf cfg.enable {
  packages = [ cfg.package ];

  enterShell = lib.mkAfter ''
    # Copy the generated taskfile to the project directory
    if [ ! -z "${cfg.taskfilePath}" ] then
      cp ${taskfileFile} "${cfg.taskfilePath}"
      echo "Generated ${cfg.taskfilePath} with ${toString (lib.length (lib.attrNames cfg.taskfile.tasks))} tasks"
    fi
  '';
}
