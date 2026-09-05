{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.editors.fonts;
in {
  options.invariant.editors.fonts = {
    enable = mkEnableOption "Developer Fonts (JetBrains Mono Nerd Font)";
  };

  config = mkIf cfg.enable {
    # Active la découverte des polices utilisateur (notamment sur Linux)
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
