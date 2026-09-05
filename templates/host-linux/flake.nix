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

  outputs = { self, nixpkgs, home-manager, invariant, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # 🛠️ App d'initialisation locale (zéro configuration manuelle)
    apps.${system}.init = {
      type = "app";
      program = "${pkgs.writeShellScriptBin "init" ''
        #!/usr/bin/env bash
        set -euo pipefail

        HOSTNAME=$(hostname -s)
        USERNAME=$(id -un)

        echo "🚀 Initializing Linux host configuration for $USERNAME@$HOSTNAME..."

        ${pkgs.gnused}/bin/sed -i "s/<HOSTNAME>/$HOSTNAME/g" flake.nix
        ${pkgs.gnused}/bin/sed -i "s/<USERNAME>/$USERNAME/g" flake.nix

        git add flake.nix Taskfile.yml 2>/dev/null || true

        echo "✅ Successfully configured flake.nix for $USERNAME@$HOSTNAME!"
        echo ""
        echo "Next step: Run the initial bootstrap:"
        echo "  nix run github:nix-community/home-manager -- switch --flake .#$USERNAME@$HOSTNAME -b backup"
      ''}/bin/init";
    };

    homeConfigurations."<USERNAME>@<HOSTNAME>" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        # baseline.homeManagerModules.default
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
