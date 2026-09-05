{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.core.terminal;
in {
  options.invariant.core.terminal = {
    enable = mkEnableOption "Zellij Terminal Multiplexer";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
