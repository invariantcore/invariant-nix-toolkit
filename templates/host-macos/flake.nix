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
        read -r -p "Git User Name [Fabien Lassagne]: " GIT_NAME
        GIT_NAME=''${GIT_NAME:-Fabien Lassagne}
        read -r -p "Git User Email: " GIT_EMAIL

        echo "🚀 Initializing macOS host configuration for $USERNAME@$HOSTNAME..."

        ${pkgs.gnused}/bin/sed -i "s/<HOSTNAME>/$HOSTNAME/g" flake.nix
        ${pkgs.gnused}/bin/sed -i "s/<USERNAME>/$USERNAME/g" flake.nix
        ${pkgs.gnused}/bin/sed -i "s/<GIT_NAME>/$GIT_NAME/g" flake.nix
        ${pkgs.gnused}/bin/sed -i "s/<GIT_EMAIL>/$GIT_EMAIL/g" flake.nix

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

          # Workstation macOS GUI tools (Display, Window Management & Craft Apps)
          homebrew = {
            enable = true;
            taps = [
              "nikitabobko/tap"
            ];
            casks = [
              "betterdisplay"
              "nikitabobko/tap/aerospace"
              "ghostty"
              "zed"
              "raycast"
              "alt-tab"
            ];
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

            programs.git = {
              userName = "<GIT_NAME>";
              userEmail = "<GIT_EMAIL>";
            };

            # Configuration déclarative AeroSpace (binaire installé via Homebrew Cask pour préserver TCC)
            xdg.configFile."aerospace/aerospace.toml".text = ''
              start-at-login = true

              # Normalisation automatique des conteneurs
              enable-normalization-flatten-containers = true
              enable-normalization-opposite-orientation-for-nested-containers = true
              accordion-padding = 30

              [gaps]
              inner.horizontal = 12
              inner.vertical = 12
              outer.left = 12
              outer.bottom = 12
              outer.top = 12
              outer.right = 12

              [mode.main.binding]
              # 1. Se déplacer entre les colonnes / dans la pile centrale (Ctrl + Alt + Flèches)
              ctrl-alt-left = 'focus left'
              ctrl-alt-down = 'focus down'
              ctrl-alt-up = 'focus up'
              ctrl-alt-right = 'focus right'

              # 2. Déplacer / Swapper une fenêtre de colonne (Ctrl + Alt + Shift + Flèches)
              ctrl-alt-shift-left = 'move left'
              ctrl-alt-shift-down = 'move down'
              ctrl-alt-shift-up = 'move up'
              ctrl-alt-shift-right = 'move right'

              # 3. Fusionner une fenêtre dans la pile centrale (Ctrl + Alt + Cmd + Flèches)
              ctrl-alt-cmd-left = 'join-with left'
              ctrl-alt-cmd-down = 'join-with down'
              ctrl-alt-cmd-up = 'join-with up'
              ctrl-alt-cmd-right = 'join-with right'

              # 4. Basculer entre Mode Colonnes (Tiles) et Mode Pile (Accordion)
              ctrl-alt-space = 'layout accordion horizontal vertical'
              ctrl-alt-return = 'layout tiles horizontal vertical'
              ctrl-alt-f = 'fullscreen'
              ctrl-alt-shift-space = 'layout floating tiling'

              # 5. Redimensionner la colonne centrale (+300px / -300px)
              ctrl-alt-equal = 'resize smart +300'
              ctrl-alt-minus = 'resize smart -300'

              # 6. Navigation entre Workspaces (Ctrl + Alt + PageUp/PageDown ou F1..F4)
              ctrl-alt-pageUp = 'workspace --wrap-around prev'
              ctrl-alt-pageDown = 'workspace --wrap-around next'
              ctrl-alt-f1 = 'workspace 1'
              ctrl-alt-f2 = 'workspace 2'
              ctrl-alt-f3 = 'workspace 3'
              ctrl-alt-f4 = 'workspace 4'
              ctrl-alt-shift-f1 = 'move-node-to-workspace 1 --focus-follows-window'
              ctrl-alt-shift-f2 = 'move-node-to-workspace 2 --focus-follows-window'
              ctrl-alt-shift-f3 = 'move-node-to-workspace 3 --focus-follows-window'
              ctrl-alt-shift-f4 = 'move-node-to-workspace 4 --focus-follows-window'
            '';
          };
        }
      ];
    };
  };
}
