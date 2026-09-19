{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.editors;
in {
  imports = [
    ./fonts.nix
  ];

  options.invariant.editors = {
    enable = mkEnableOption "Invariant Editors & Typography Toolkit";
  };

  config = mkIf cfg.enable {
    invariant.editors.fonts.enable = mkDefault true;
  };
}
