{ pkgs, ... }: {
  # 1. Nix daemon management (managed by Determinate Systems installer)
  nix.enable = false;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # 2. Enterprise applications (Homebrew Cask fallback)
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    casks = [
      # Add required enterprise casks here
    ];
  };

  # 3. macOS system defaults
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
  };

  system.stateVersion = 5;
}
