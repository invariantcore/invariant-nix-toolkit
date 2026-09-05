{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.editors.zed;
in {
  options.invariant.editors.zed = {
    enable = mkEnableOption "Zed Editor (Pure Nix)";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
