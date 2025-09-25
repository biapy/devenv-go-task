{
  description = "devenv-go-task";

  inputs = {};

  outputs = { self }:
    {
      plugin = (import ./default.nix);
    };
}