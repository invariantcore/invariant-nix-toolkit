{
  description = "Workstation Host Composition (Invariant x Enterprise Linux)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Toolkit Invariant Core
    invariant.url = "github:invariantcore/invariant-nix-toolkit";
    # baseline.url = "git+ssh://git@github.com/<ORG>/<REPO>.git";
  };

  outputs = { self, nixpkgs, home-manager, invariant, ... }: {
    homeConfigurations."<USERNAME>" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        # baseline.homeManagerModules.corporate
        invariant.homeManagerModules.default
        {
          home.username = "<USERNAME>";
          home.homeDirectory = "/home/<USERNAME>";
          home.stateVersion = "24.05";
          programs.home-manager.enable = true;
          invariant.enable = true;
        }
      ];
    };
  };
}
