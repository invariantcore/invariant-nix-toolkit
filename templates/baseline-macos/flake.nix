{
  description = "Enterprise Workstation Baseline (macOS)";

  inputs = {};

  outputs = { self }: {
    darwinModules.default = import ./modules/darwin.nix;
    homeManagerModules.corporate = import ./modules/home-corporate.nix;
  };
}
