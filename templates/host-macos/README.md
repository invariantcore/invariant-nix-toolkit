# Host Composition Template (macOS)

This template scaffolds your local workstation configuration on macOS using `nix-darwin` and `home-manager`.

## 🚀 Getting Started

### 1. Initialize your dotfiles repository
```bash
mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
git init
nix flake init -t github:invariantcore/invariant-nix-toolkit#host-macos
```

### 2. Configure `flake.nix`
* Replace `<HOSTNAME>` with your machine's hostname.
* Replace `<USERNAME>` with your macOS username.
* Update `baseline.url` with your organization's baseline repository.
* Stage your configuration:
  ```bash
  git add flake.nix
  ```

### 3. First-time Bootstrap (Initial Activation)
If `nix-darwin` is not yet installed in your system PATH, use `nix run`:
```bash
nix run nix-darwin -- switch --flake .#<HOSTNAME>
```
*(Or if `nix-darwin` is already present: `sudo darwin-rebuild switch --flake .#<HOSTNAME>`)*

---

## 🔄 Daily Workflow (Subsequent Updates)

Once bootstrapped, you can rebuild your system using:
```bash
sudo darwin-rebuild switch --flake ~/.config/dotfiles#<HOSTNAME>
```
