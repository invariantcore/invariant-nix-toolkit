{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.invariant.platform.tools;
in {
  options.invariant.platform.tools = {
    enable = mkEnableOption "Cloud, Automation & Inspection Tools (devbox, go-task, kcl, jq, yq, dust)";
  };

  config = mkIf cfg.enable {
    programs.jq.enable = true;

    home.packages = with pkgs; [
      coreutils
      devbox
      go-task # Commande 'task' (Taskfile runner)
      kcl     # Langage de configuration Cloud-Native & K8s
      yq-go
      dust
    ];
  };
}
