{
  description = "Enterprise Workstation Baseline (macOS)";

  inputs = {};

  outputs = { self }: {
    darwinModules.default = import ./modules/darwin.nix;
    homeManagerModules = {
      default  = import ./modules/home;
      security = import ./modules/home/security.nix;
    };
  };
}
