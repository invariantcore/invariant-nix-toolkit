# Host Composition Template (macOS)

This template scaffolds your local workstation configuration on macOS using `nix-darwin` and `home-manager`.

## 🚀 Getting Started

### 1. Initialize your dotfiles repository
```bash
mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
git init
nix flake init -t github:invariantcore/invariant-nix-toolkit#host-macos
```

### 2. Auto-configure your host (`init` app)
Run the local initialization app to automatically detect your macOS hostname and username, update `flake.nix`, and stage files in git:
```bash
nix run .#init
```
*(Optional: edit `baseline.url` in `flake.nix` if you are connecting an enterprise baseline).*

### 3. First-time Bootstrap (Initial Activation)
If `nix-darwin` is not yet installed in your system PATH, use `nix run`:
```bash
nix run nix-darwin -- switch --flake .#<USERNAME>@<HOSTNAME>
```
*(Or if `nix-darwin` is already present: `sudo darwin-rebuild switch --flake .#<USERNAME>@<HOSTNAME>`)*

---

## 🔄 Daily Workflow (`task`)

Once bootstrapped, `task` (Go-Task) is installed in your `$PATH`. Use the universal `nx:` tasks:

* **Apply configuration changes:**
  ```bash
  task nx:switch
  ```
* **Update all dependencies & rebuild:**
  ```bash
  task nx:update
  ```
* **Update only Invariant Core toolkit (fast):**
  ```bash
  task nx:update:toolkit
  ```
* **Clean old generations & optimize store:**
  ```bash
  task nx:gc
  ```
* **List all available operations:**
  ```bash
  task
  ```
