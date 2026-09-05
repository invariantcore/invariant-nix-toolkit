{ config, lib, ... }:
with lib;
let
  cfg = config.invariant;
in {
  imports = [
    ./core
    ./platform
    ./editors
  ];

  options.invariant = {
    enable = mkEnableOption "Invariant Core DevOps & Craft Toolkit (All-in-One)";
  };

  config = mkIf cfg.enable {
    # Active les 3 domaines par défaut si le master switch est activé
    invariant.core.enable = mkDefault true;
    invariant.platform.enable = mkDefault true;
    invariant.editors.enable = mkDefault true;
  };
}
