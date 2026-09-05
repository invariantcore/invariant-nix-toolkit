# Host Composition Template (Linux)

This template scaffolds your local workstation configuration on Linux using standalone `home-manager`.

## 🚀 Getting Started

1. Initialize in your dotfiles directory:
   ```bash
   mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
   nix flake init -t github:invariantcore/invariant-nix-toolkit#host-linux
   ```
2. In `flake.nix`:
   - Replace `<USERNAME>` with your Linux username.
   - Adjust `pkgs.legacyPackages."x86_64-linux"` (or `aarch64-linux`).
   - Optionally uncomment `baseline.url` if you have an organizational baseline.
3. Apply the configuration:
   ```bash
   home-manager switch --flake .#<USERNAME>
   ```
