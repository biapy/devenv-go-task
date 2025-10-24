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
let
  inherit (pkgs) yq-go;
  inherit (lib.attrsets)
    isAttrs
    filterAttrsRecursive
    attrNames
    mergeAttrsList
    zipAttrsWith
    ;
  inherit (lib.strings) isString splitString concatStringsSep;
  inherit (lib.lists)
    all
    concatLists
    flatten
    head
    isList
    last
    length
    map
    range
    tail
    take
    unique
    uniqueStrings
    ;
  inherit (builtins) toJSON;

  cfg = config.biapy.go-task;
  yqCommand = lib.meta.getExe yq-go;

  prefixSeparator = cfg.prefixed-tasks.separator;

  # Split a string by ':' and return all cumulative prefixes
  getPrefixes =
    str:
    assert isString str;
    let
      parts = splitString prefixSeparator str;
    in
    map (i: concatStringsSep prefixSeparator (take i parts)) (range 1 ((length parts) - 1));

  escapeRegex =
    char:
    assert isString char;
    let
      escapedCharacters = [
        "["
        "]"
        "."
        "$"
        "^"
        "|"
      ];
    in
    if builtins.elem char escapedCharacters then "\\" + char else char;

  buildPrefixRunnerTask =
    taskPrefix:
    assert isString taskPrefix;
    let
      escapedSeparator = escapeRegex prefixSeparator;
      grepExtendedRegexp = "{{.TASK}}${escapedSeparator}[^${escapedSeparator}]+$";
    in
    {
      "${taskPrefix}" = {
        summary = "🗂️ Run '${taskPrefix}${prefixSeparator}*' tasks";
        vars = {
          TASKS = {
            sh = concatStringsSep " | " [
              "task --json --list-all"
              "yq '.tasks[].name'"
              "grep --only-matching --extended-regexp '${grepExtendedRegexp}'"
            ];
          };
        };
        deps = [
          {
            for = {
              var = "TASKS";
            };
            task = "{{.ITEM}}";
          }
        ];
        silent = true;
        ignore_error = true;
        requires.vars = [ "DEVENV_ROOT" ];
      };
    };

  # Get all unique prefixes from a list of strings
  tasksNames = attrNames cfg.taskfile.tasks;
  tasksPrefixes = uniqueStrings (flatten (map getPrefixes tasksNames));
  prefixRunnerTasks = mergeAttrsList (map buildPrefixRunnerTask tasksPrefixes);

  defaultListTask = {
    list = {
      desc = "List available tasks";
      cmds = [ "task --list" ];
      aliases = [ "default" ];
      silent = true;
    };
  };

  # See https://discourse.nixos.org/t/nix-function-to-merge-attributes-records-recursively-and-concatenate-arrays/2030/7
  # See https://stackoverflow.com/questions/54504685/nix-function-to-merge-attributes-records-recursively-and-concatenate-arrays/54505212#54505212
  recursiveMerge =
    attrList:
    let
      f =
        attrPath:
        zipAttrsWith (
          n: values:
          if tail values == [ ] then
            head values
          else if all isList values then
            unique (concatLists values)
          else if all isAttrs values then
            f (attrPath ++ [ n ]) values
          else
            last values
        );
    in
    f [ ] attrList;

  tasks = defaultListTask // (if cfg.prefixed-tasks.enable then prefixRunnerTasks else { });

  taskfile = recursiveMerge [
    cfg.taskfile
    { inherit tasks; }
  ];

  isNotEmpty = _: value: value != null && value != [ ] && value != { };
  filteredTaskfile = filterAttrsRecursive isNotEmpty taskfile;

  # Convert to YAML string (toYAML(options, value))
  yamlContent = toJSON filteredTaskfile;

  # Create the taskfile as JSON (compatible with YAML)
  taskfileFile = pkgs.writeText "taskfile.json" yamlContent;
in
{
  config = lib.mkIf cfg.enable {
    packages = [
      cfg.package
      yq-go
    ];

    enterShell = lib.mkAfter ''
      ${yqCommand} --input-format 'json' --output-format 'yaml' '${taskfileFile}' > '${cfg.taskfilePath}'
      echo 'Generated ${cfg.taskfilePath} with ${toString (lib.length (lib.attrNames cfg.taskfile.tasks))} tasks'
    '';
  };
}
