{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.platform;
in {
  imports = [
    ./kubernetes.nix
    ./gitops.nix
    ./tools.nix
  ];

  options.invariant.platform = {
    enable = mkEnableOption "Invariant Platform & Cloud Engineering Toolkit";
  };

  config = mkIf cfg.enable {
    invariant.platform.kubernetes.enable = mkDefault true;
    invariant.platform.gitops.enable = mkDefault true;
    invariant.platform.tools.enable = mkDefault true;
  };
}
