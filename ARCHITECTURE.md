# Architecture

This document explains the architecture and design decisions for the
`devenv-go-task` module.

## Overview

The devenv-go-task module is designed as a devenv.nix plugin that provides
declarative configuration for go-task, a task runner/build tool written in Go.

## File Structure

```text
├── modules/go-task/devenv.nix          # Main module definition
├── example/             # Example usage
│   ├── devenv.nix       # Example devenv configuration
│   └── devenv.yaml      # Example devenv inputs
├── test/                # Test configurations
│   ├── minimal.nix      # Minimal test case
│   └── comprehensive.nix # Full feature test
└── README.md            # User documentation
```

## Module Design

### Options Structure

The module provides a hierarchical configuration structure:

```nix
go-task = {
  enable = <bool>;           # Enable/disable the module
  package = <package>;       # go-task package to use
  taskfile = <string>;       # Output taskfile path
  settings = {               # Global taskfile settings
    version = <string>;
    vars = <attrset>;
    env = <attrset>;
    # ... other global options
  };
  tasks = {                  # Task definitions
    <task-name> = {
      desc = <string>;
      cmds = [<string>];
      deps = [<string>];
      # ... other task options
    };
  };
}
```

### Configuration Processing

1. **Option Definition**: All configuration options are defined by using NixOS
   module system with proper types, defaults, and descriptions.

2. **Data Transformation**: The configuration is transformed from Nix attribute
   sets to YAML-compatible data structures.

3. **Filtering**: Empty/null values are filtered out to produce clean YAML
   output.

4. **YAML Generation**: The processed configuration is converted to YAML
   using `lib.generators.toYAML`.

5. **File Creation**: A text file containing the YAML is created by using
   `pkgs.writeText`.

6. **Integration**: The generated taskfile is copied to the project directory
   during `enterShell`.

### Key Design Decisions

#### 1. Comprehensive Option Coverage

The module supports all major go-task features:

- Global settings (vars, env, output modes)
- Task-specific configurations
- Dependencies and preconditions
- Source/generate file tracking
- Multiple task execution methods

#### 2. Type Safety

All options use proper Nix types:

- `lib.types.bool` for boolean flags
- `lib.types.str` for strings
- `lib.types.listOf` for arrays
- `lib.types.attrsOf` for key-value pairs
- `lib.types.submodule` for nested configurations

#### 3. Sensible Defaults

- `go-task.enable = false` (opt-in)
- `go-task.taskfile = "Taskfile.dist.yml"` (standard location)
- `go-task.settings.version = "3"` (current version)
- Empty collections default to `[]` or `{}`

#### 4. Integration with devenv

- Adds go-task package to devenv packages when enabled
- Generates taskfile during shell initialization
- Provides feedback about generated tasks
- Follows devenv conventions

## Implementation Details

### YAML Generation

The YAML generation process handles several edge cases:

1. **Empty Value Filtering**: Null values, empty lists, empty attribute sets,
   and false booleans are filtered out to avoid cluttering the output.

2. **Nested Structure Support**: Task preconditions are handled as nested
   submodules with proper conversion.

3. **Type Preservation**: Strings, numbers, and booleans are preserved
   correctly in the YAML output.

### Error Handling

The module is designed to fail gracefully:

- Invalid configurations are caught by Nix's type system
- Missing dependencies are handled by go-task itself
- File generation errors are reported during shell initialization

### Performance Considerations

- YAML generation happens once during shell initialization
- Generated taskfiles are cached by Nix
- No runtime overhead after initial generation

## Extension Points

The module can be extended in several ways:

1. **Additional Task Options**: New go-task features can be added by
   extending the task submodule.
2. **Global Settings**: New global options can be added to the settings
   submodule.
3. **Custom Validation**: Additional validation can be added using
   `lib.mkAssert`.
4. **Integration**: Additional devenv integration points can be added beyond
   `enterShell`.

## Testing Strategy

The module includes several test configurations:

1. **Minimal Test**: Verifies basic functionality with minimal configuration.
2. **Comprehensive Test**: Tests all available features and edge cases.
3. **Syntax Validation**: Python scripts validate generated Nix and YAML syntax.
4. **Example Validation**: Real-world examples demonstrate practical usage.

## Comparison with Alternatives

### Manual Taskfile Management

**Advantages of devenv-go-task:**

- Declarative configuration
- Type safety
- Integration with devenv
- Version control of task definitions
- Reusable configurations

**Advantages of manual Taskfile.yml:**

- Direct control over YAML structure
- IDE support for YAML editing
- No dependency on Nix knowledge

### Other Task Runners

The module specifically targets go-task because:

- Active development and good documentation
- YAML-based configuration (easy to generate)
- Rich feature set (dependencies, variables, etc.)
- Cross-platform compatibility
- Good integration with development workflows
