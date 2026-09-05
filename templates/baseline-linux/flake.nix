{
  description = "Enterprise Workstation Baseline (Linux)";

  inputs = {};

  outputs = { self }: {
    homeManagerModules = {
      default  = import ./modules/home;
      security = import ./modules/home/security.nix;
    };
  };
}
