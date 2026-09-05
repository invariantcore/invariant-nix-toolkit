{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.core.git;
in {
  options.invariant.core.git = {
    enable = mkEnableOption "Git & Delta pager";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
