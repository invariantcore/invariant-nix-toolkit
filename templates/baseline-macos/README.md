# Enterprise Workstation Baseline (macOS)

This repository defines the corporate baseline for macOS developer workstations. It captures organization-wide compliance requirements, internal root CA certificates, required enterprise applications, and OS defaults.

## 🛠️ Configuration

* `modules/darwin.nix`: Enterprise Homebrew Casks, system settings, and OS-level policies.
* `modules/home-corporate.nix`: User-level environment variables, proxy configurations, and corporate certificates.

## 📦 Exported Modules

* `darwinModules.default`: System-level macOS configuration.
* `homeManagerModules.corporate`: User-level corporate environment variables.
