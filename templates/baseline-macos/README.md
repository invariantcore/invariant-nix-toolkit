# Enterprise Workstation Baseline (macOS)

This repository defines the corporate baseline for macOS developer workstations. It captures organization-wide compliance requirements, internal root CA certificates, required enterprise applications, and OS defaults.

## 🛠️ Configuration

* `modules/darwin.nix`: Enterprise Homebrew Casks, system settings, and OS-level policies.
* `modules/home/default.nix`: Aggregator module importing all corporate user-level modules.
* `modules/home/security.nix`: Corporate TLS root CA certificates, proxy settings, and environment variables.

## 📦 Exported Modules

* `darwinModules.default`: System-level macOS configuration.
* `homeManagerModules.default`: Complete corporate user-level bundle.
* `homeManagerModules.security`: Standalone corporate proxy and TLS root certificate configuration.
