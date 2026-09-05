{
  description = "Workstation Host Composition (Invariant x Enterprise Baseline)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Baseline d'organisation & Toolkit Invariant Core
    baseline.url = "git+ssh://git@github.com/<ORG>/<REPO>.git";
    invariant.url = "github:invariantcore/invariant-nix-toolkit";
  };

  outputs = { self, nixpkgs, darwin, home-manager, baseline, invariant, ... }: {
    darwinConfigurations."<HOSTNAME>" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        baseline.darwinModules.default
        {
          system.primaryUser = "<USERNAME>";

          # Autorise Fish dans /etc/shells au niveau de l'OS pour l'utilisateur
          environment.shells = [ nixpkgs.legacyPackages.aarch64-darwin.fish ];
          programs.fish.enable = true;

          users.users."<USERNAME>" = {
            name = "<USERNAME>";
            home = "/Users/<USERNAME>";
            shell = nixpkgs.legacyPackages.aarch64-darwin.fish;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."<USERNAME>" = {
            imports = [
              baseline.homeManagerModules.default
              invariant.homeManagerModules.default
            ];
            home.username = "<USERNAME>";
            home.homeDirectory = "/Users/<USERNAME>";
            home.stateVersion = "24.05";
            invariant.enable = true;
          };
        }
      ];
    };
  };
}
