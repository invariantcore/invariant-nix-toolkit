# Host Composition Template (Linux)

This template scaffolds your local workstation configuration on Linux using standalone `home-manager`.

## 🚀 Getting Started

### 1. Initialize your dotfiles repository
```bash
mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
git init
nix flake init -t github:invariantcore/invariant-nix-toolkit#host-linux
```

### 2. Configure `flake.nix`
* Replace `<USERNAME>` with your Linux username (`id -un`).
* Adjust architecture if needed (`x86_64-linux` or `aarch64-linux`).
* Stage your configuration:
  ```bash
  git add flake.nix Taskfile.yml
  ```

### 3. First-time Bootstrap (Initial Activation)
Since the `home-manager` CLI is not yet in your `$PATH`, use `nix run` for the initial deployment:
```bash
nix run github:nix-community/home-manager -- switch --flake .#<USERNAME> -b backup
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
