{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.platform.kubernetes;
in {
  options.invariant.platform.kubernetes = {
    enable = mkEnableOption "Kubernetes Tools (kubectl, helm, k9s, kubectx)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      kubernetes-helm
      kubectx # Fournit 'kubectx' et 'kubens'
    ];

    # K9s managé par Home Manager
    programs.k9s.enable = true;

    # Raccourcis Fish injectés si le shell Invariant est actif
    programs.fish.shellAliases = mkIf (config.invariant.core.shell.enable or false) {
      k = "kubectl";
      kx = "kubectx";
      kn = "kubens";
    };
  };
}
