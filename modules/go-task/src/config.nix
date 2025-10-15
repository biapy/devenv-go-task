/**
  # go-task Taskfile generation

  generates a Taskfile for `task`, if `biapy.go-task.enable` is `true`.

  ## 🙇 Acknowledgements

  - [Generators @ NixPkgs documentation](https://nixos.org/manual/nixpkgs/stable/#sec-generators);
  - [builtins.toJSON @ Noogle](https://noogle.dev/f/builtins/toJSON).
*/
{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.biapy.go-task.enable (
  let
    inherit (pkgs) yq-go;
    inherit (lib.attrsets) filterAttrsRecursive;
    inherit (builtins) toJSON;

    yqCommand = lib.meta.getExe yq-go;

    cfg = config.biapy.go-task;

    isNotEmpty = _: value: value != null && value != [ ] && value != { };
    filteredTaskfile = filterAttrsRecursive isNotEmpty cfg.taskfile;

    # Convert to YAML string (toYAML(options, value))
    yamlContent = toJSON filteredTaskfile;

    # Create the taskfile
    taskfileFile = pkgs.writeText "taskfile" yamlContent;
  in
  {
    packages = [
      cfg.package
      yq-go
    ];

    enterShell = lib.mkAfter ''
      ${yqCommand} --input-format 'json' --output-format 'yaml' '${taskfileFile}' > '${cfg.taskfilePath}'
      echo 'Generated ${cfg.taskfilePath} with ${toString (lib.length (lib.attrNames cfg.taskfile.tasks))} tasks'
    '';
  }
)
