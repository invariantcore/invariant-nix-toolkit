{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.core.shell;
in {
  options.invariant.core.shell = {
    enable = mkEnableOption "Fish shell, Starship prompt & Modern Unix CLI";
  };

  config = mkIf cfg.enable {
    # 1. Outils CLI autonomes
    home.packages = with pkgs; [
      fd
    ];

    # 2. Bat (syntax highlighting pour les fichiers)
    programs.bat.enable = true;

    # 3. Eza (remplaçant moderne de ls avec icônes et git)
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = "auto";
    };

    # 4. Fzf (recherche floue avec keybindings Ctrl+R et Ctrl+T dans Fish)
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    # 5. Ripgrep (recherche textuelle ultra-rapide)
    programs.ripgrep.enable = true;

    # 6. Fish Shell & Plugins déclaratifs
    programs.fish = {
      enable = true;

      plugins = [
        { name = "z"; src = pkgs.fishPlugins.z.src; }
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
      ];

      shellAliases = {
        # Navigation & listes
        ll = "eza -lh --git";
        la = "eza -lah --git";
        tree = "eza --tree";

        # Remplaçants modernes
        cat = "bat";
        grep = "rg";
        find = "fd";

        # Raccourcis fréquents
        g = "git";
      };

      interactiveShellInit = ''
        # Initialisation automatique de Homebrew sur Apple Silicon si présent
        if test -d /opt/homebrew
          eval (/opt/homebrew/bin/brew shellenv)
        end
      '';
    };

    # 7. Starship Prompt
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
