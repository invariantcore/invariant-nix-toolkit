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

  outputs = { self, nixpkgs, darwin, home-manager, baseline, invariant, ... }:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # 🛠️ App d'initialisation locale (zéro configuration manuelle)
    apps.${system}.init = {
      type = "app";
      program = "${pkgs.writeShellScriptBin "init" ''
        #!/usr/bin/env bash
        set -euo pipefail

        HOSTNAME=$(scutil --get LocalHostName)
        USERNAME=$(id -un)

        echo "🚀 Initializing macOS host configuration for $USERNAME@$HOSTNAME..."

        ${pkgs.gnused}/bin/sed -i "s/<HOSTNAME>/$HOSTNAME/g" flake.nix
        ${pkgs.gnused}/bin/sed -i "s/<USERNAME>/$USERNAME/g" flake.nix

        git add flake.nix Taskfile.yml 2>/dev/null || true

        echo "✅ Successfully configured flake.nix for $USERNAME@$HOSTNAME!"
        echo ""
        echo "Next step: Run the initial bootstrap:"
        echo "  nix run nix-darwin -- switch --flake .#$USERNAME@$HOSTNAME"
      ''}/bin/init";
    };

    darwinConfigurations."<USERNAME>@<HOSTNAME>" = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        baseline.darwinModules.default
        {
          system.primaryUser = "<USERNAME>";

          # Autorise Fish dans /etc/shells au niveau de l'OS pour l'utilisateur
          environment.shells = [ pkgs.fish ];
          programs.fish.enable = true;

          users.users."<USERNAME>" = {
            name = "<USERNAME>";
            home = "/Users/<USERNAME>";
            shell = pkgs.fish;
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
