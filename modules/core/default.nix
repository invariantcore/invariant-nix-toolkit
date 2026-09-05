{ config, lib, ... }:
with lib;
let
  cfg = config.invariant.core;
in {
  imports = [
    ./shell.nix
    ./git.nix
    ./terminal.nix
  ];

  options.invariant.core = {
    enable = mkEnableOption "Invariant Core Foundation (Shell, Git, Multiplexer)";
  };

  config = mkIf cfg.enable {
    invariant.core.shell.enable = mkDefault true;
    invariant.core.git.enable = mkDefault true;
    invariant.core.terminal.enable = mkDefault true;
  };
}
