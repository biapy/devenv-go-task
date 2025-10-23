/**
  # For loop schema
*/
{ lib, ... }:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    either
    oneOf
    nullOr
    listOf
    attrsOf
    ;

  localTypes = {
    forList = listOf types.str;
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
          type = nullOr types.str;
          defaultText = ''" "'';
          default = null;
          description = "String to split the variable on";
        };
        as = mkOption {
          type = nullOr types.str;
          description = "What the loop variable should be named.";
          defaultText = "ITEM";
          default = null;
        };
      };
    };

    forMatrix = types.submodule {
      options = {
        matrix = attrsOf types.list;
      };
    };
  };
in
oneOf [
  (either localTypes.forList localTypes.forVar)
  (either localTypes.forAttribute localTypes.forMatrix)
]
