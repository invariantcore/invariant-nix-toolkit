# Host Composition Template (macOS)

This template scaffolds your local workstation configuration (`~/.config/dotfiles`) on macOS using `nix-darwin` and `home-manager`.

## 🚀 Getting Started

1. Initialize in your dotfiles directory:
   ```bash
   mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
   nix flake init -t github:invariantcore/invariant-nix-toolkit#host-macos
   ```
2. In `flake.nix`:
   - Replace `<HOSTNAME>` with your machine's hostname.
   - Replace `<USERNAME>` with your macOS username.
   - Update `baseline.url` with your organization's baseline repository.
3. Apply the configuration:
   ```bash
   sudo darwin-rebuild switch --flake .#<HOSTNAME>
   ```
