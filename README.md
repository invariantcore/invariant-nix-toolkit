# Invariant Nix Toolkit ❄️

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-5277C3.svg?logo=nixos&logoColor=white)](https://nixos.org)

Modular, OS-agnostic Nix and Home Manager modules & bootstrap templates for modern Platform Engineering and Software Craftsmanship workstations (macOS & Linux).

Designed and maintained by [Invariant Core](https://github.com/invariantcore).

---

## 🏛️ Philosophy & Architecture

- **Pure Module Flake:** Zero mandatory external inputs (`inputs = {}`). No recursive `follows` boilerplate.
- **Separation of Concerns:**
  - **`invariant-nix-toolkit` (This repo):** Agnostic Craft & Platform tooling (Shell, Multiplexer, Git, K8s, Editors).
  - **Organizational Baseline:** Company compliance (custom root CA, proxy settings, required enterprise applications, system policies).
  - **Host Composition:** Minimal local glue (~25 lines in `~/.config/dotfiles`) binding the baseline and your toolkit.
- **Consentful Deduplication:** Tools can be declared both here and in organizational baselines with zero runtime conflict or disk waste thanks to `/nix/store` content-addressability.

---

## 📂 Domain Breakdown

The toolkit is split into three orthogonal domains:

### 1. `core/` (Universal Productivity)

- **Shell:** [Fish Shell](https://fishshell.com) with [Starship](https://starship.rs) prompt.
- **Modern CLI:** `bat`, `eza` (git & icon integrations), `fzf` (fuzzy search keybindings), `ripgrep`, `fd`.
- **VCS:** [Git](https://git-scm.com) & [Delta](https://github.com/dandavison/delta) pager.
- **Multiplexer:** [Zellij](https://zellij.dev).

### 2. `platform/` (Platform Engineering & Kubernetes)

- **Kubernetes:** `kubectl`, `kubernetes-helm`, `k9s`, `kubectx` (with `kubens`).
- **GitOps:** `argocd`, `kustomize`.
- **Automation & Inspection:** `devbox` (per-project IaC / compiler engine), `go-task` (`task`), `kcl`, `jq`, `yq-go`, `dust`, `coreutils`.

### 3. `editors/` (Editing & Typography)

- **Editor:** [Zed](https://zed.dev) (Pure Nix package, Linux & macOS).
- **Typography:** [JetBrains Mono Nerd Font](https://www.nerdfonts.com/).

---

## ⚙️ Options Reference

| Option                      | Default | Description                                                         |
| :-------------------------- | :-----: | :------------------------------------------------------------------ |
| `invariant.enable`          | `false` | Master toggle: enables all domains (`core`, `platform`, `editors`). |
| `invariant.core.enable`     | `false` | Enables shell, modern CLI, git, delta, and zellij.                  |
| `invariant.platform.enable` | `false` | Enables Kubernetes, GitOps, and platform inspection tools.          |
| `invariant.editors.enable`  | `false` | Enables Zed editor and JetBrains Mono Nerd Font.                    |

---

## 🚀 Quickstart & Templates

`invariant-nix-toolkit` provides 4 native templates to scaffold workstations and organizational baselines:

```bash
# 1. Initialize your local workstation host
mkdir -p ~/.config/dotfiles && cd ~/.config/dotfiles
nix flake init -t github:invariantcore/invariant-nix-toolkit#host-macos # (or #host-linux)

# 2. Initialize an organizational baseline repository
cd <organization>-workstation
nix flake init -t github:invariantcore/invariant-nix-toolkit#baseline-macos # (or #baseline-linux)
```

| Template             | Target        | Role                                                                                 |
| :------------------- | :------------ | :----------------------------------------------------------------------------------- |
| **`host-macos`**     | Local Machine | Local macOS host composition (`nix-darwin` + `home-manager`).                        |
| **`host-linux`**     | Local Machine | Local Linux host composition (standalone `home-manager`).                            |
| **`baseline-macos`** | Organization  | Enterprise macOS baseline (corporate CA / proxy, enterprise casks, system defaults). |
| **`baseline-linux`** | Organization  | Enterprise Linux baseline (corporate CA / proxy, corporate environment variables).   |

---

## 📄 License

Distributed under the [MIT License](LICENSE).
