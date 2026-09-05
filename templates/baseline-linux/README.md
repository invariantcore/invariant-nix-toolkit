# Enterprise Workstation Baseline (Linux)

This repository defines the corporate baseline for Linux developer workstations (internal root CA certificates, proxy configurations, and corporate environment variables).

## 🛠️ Configuration

* `modules/home/default.nix`: Aggregator module importing all corporate user-level modules.
* `modules/home/security.nix`: Corporate TLS root CA certificates, proxy settings, and environment variables.

## 📦 Exported Modules

* `homeManagerModules.default`: Complete corporate user-level bundle.
* `homeManagerModules.security`: Standalone corporate proxy and TLS root certificate configuration.
