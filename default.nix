{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options.go-task = (import ./src/options.nix);

  config = (import ./src/config.nix);
}
