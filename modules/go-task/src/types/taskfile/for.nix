/**
  # For loop schema
*/
{ lib, ... }:
lib.types.oneOf [
  # For list
  lib.types.listOf
  lib.types.str

  # For attribute
  lib.types.enum
  [
    "sources"
    "generates"
  ]

  # For var
  lib.types.submodule
  {
    description = "Which variables to iterate over. The variable will be split using any whitespace character by default. This can be changed by using the `split` attribute.";
    options = {
      var = lib.mkOption {
        type = lib.types.str;
        description = "Name of the variable to iterate over";
      };
      split = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        defaultText = ''" "'';
        default = null;
        description = "String to split the variable on";
      };
      as = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "What the loop variable should be named.";
        defaultText = "ITEM";
        default = null;
      };
    };
  }

  # For matrix
  lib.types.submodule
  {
    description = "A matrix of values to iterate over";
    options = {
      matrix = lib.types.attrsOf lib.types.list;
    };
  }
]
