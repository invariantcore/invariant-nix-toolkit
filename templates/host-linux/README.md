# Host Composition Template (Linux)

This template scaffolds your local workstation configuration on Linux using standalone `home-manager`.

## 🚀 Getting Started

### 1. Initialize your dotfiles repository
```bash
mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
git init
nix flake init -t github:invariantcore/invariant-nix-toolkit#host-linux
```

### 2. Auto-configure your host (`init` app)
Run the local initialization app to automatically detect your Linux hostname and username, update `flake.nix`, and stage files in git:
```bash
nix run .#init
```

### 3. First-time Bootstrap (Initial Activation)
Since the `home-manager` CLI is not yet in your `$PATH`, use `nix run` for the initial deployment:
```bash
nix run github:nix-community/home-manager -- switch --flake .#<USERNAME>@<HOSTNAME> -b backup
```
*(This activates your configuration and installs the `home-manager` and `task` CLIs directly into your profile.)*

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
