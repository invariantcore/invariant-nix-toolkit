{
  description = "Enterprise Workstation Baseline (Linux)";

  inputs = {};

  outputs = { self }: {
    homeManagerModules.corporate = import ./modules/home-corporate.nix;
  };
}
