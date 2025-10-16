/**
  # For loop schema
*/
{ lib, ... }:
let
  inherit (lib) types mkOption;

  localTypes = {
    forList = types.listOf types.str;
    forAttribute = types.enum [
      "sources"
      "generates"
    ];
    forVar = types.submodule {
      options = {
        var = mkOption {
          type = types.str;
          description = "Name of the variable to iterate over";
        };
        split = mkOption {
          type = types.nullOr types.str;
          defaultText = ''" "'';
          default = null;
          description = "String to split the variable on";
        };
        as = mkOption {
          type = types.nullOr types.str;
          description = "What the loop variable should be named.";
          defaultText = "ITEM";
          default = null;
        };
      };
    };

    forMatrix = types.submodule {
      options = {
        matrix = types.attrsOf types.list;
      };
    };
  };
in
types.oneOf [
  localTypes.forList
  localTypes.forAttribute
  /**
    localTypes.forVar
    localTypes.forMatrix
  */
  types.attrs
]
