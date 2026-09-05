{
  description = "Invariant Core - DevOps & Platform Engineering Craft Toolkit";

  inputs = {};

  outputs = { self }: {
    homeManagerModules.default = import ./modules;
    homeManagerModules.core = import ./modules/core;
    homeManagerModules.platform = import ./modules/platform;
    homeManagerModules.editors = import ./modules/editors;

    templates = {
      default = self.templates.host-macos;
      host-macos = {
        path = ./templates/host-macos;
        description = "Local macOS host composition (nix-darwin + home-manager)";
      };
      host-linux = {
        path = ./templates/host-linux;
        description = "Local Linux host composition (standalone home-manager)";
      };
      baseline-macos = {
        path = ./templates/baseline-macos;
        description = "Enterprise macOS baseline (corporate CA/proxy, enterprise casks, defaults)";
      };
      baseline-linux = {
        path = ./templates/baseline-linux;
        description = "Enterprise Linux baseline (corporate CA/proxy, corporate env vars)";
      };
    };
  };
}
