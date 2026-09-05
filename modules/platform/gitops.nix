{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.platform.gitops;
in {
  options.invariant.platform.gitops = {
    enable = mkEnableOption "GitOps Tools (argocd, kustomize)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      argocd
      kustomize
    ];
  };
}
