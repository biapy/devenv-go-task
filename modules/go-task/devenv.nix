{ config, lib, pkgs, ... }: {
  options.biapy.go-task = (import ./src/options.nix) {
    inherit config;
    inherit lib;
    inherit pkgs;
  };

  config = (import ./src/config.nix) {
    inherit config;
    inherit lib;
    inherit pkgs;
  };
}
