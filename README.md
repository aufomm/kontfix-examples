# Kontfix Examples

This repository demonstrates how to use a CI/CD pipeline to manage [Kong Konnect](https://cloud.konghq.com/) control plane with the Nix module [Kontfix](https://github.com/liyangau/kontfix) and Terraform.

## About this repository

This example demonstrates:
- How to configure the Kong Konnect control plane using the Kontfix Nix module.
- Automated CI/CD workflows for infrastructure as code.

## How to use

1. Review the configuration files in the `konnect/` folder to understand the control plane setup.
2. Custom plugin schemas **must** be stored in `custom-plugin-schemas/` at the root level.
3. This example organizes control planes by region, with one file per region.
4. Learn how to set default configurations for all control planes and apply individual overrides.
5. Check the workflow files (`.github/workflows/`) to see how configurations are built and applied automatically.
6. The workflows run on self-hosted runners but are compatible with GitHub-hosted runners.

## Learning from Artifacts

This repository uploads the generated `config.tf.json` as artifacts in workflow runs. This is **intentionally done for educational purposes** so you can:
- See how Nix flake configuration translates to Terraform JSON
- Inspect the actual resource definitions
- Learn the structure of Kong Konnect control plane configurations

## Getting Started

```bash
# Clone the repository
git clone https://github.com/aufomm/kontfix-examples.git

# Set up your secrets in GitHub
# Settings → Secrets → Actions:
# - CP_ADMIN_TOKEN
# - ID_ADMIN_TOKEN
# Vault related secrets if using Vault for state and pki backends
```

## Workflow Overview

### Plan Workflow (`plan.yaml`)
- Triggers on PRs
- Generates Terraform plan and shows summary in job output
- Uploads plan artifacts for inspection

### Apply Workflow (`apply.yaml`)
- Auto-triggers when PR with `terraform:auto-deploy` label is merged
- Can also be manually triggered via workflow dispatch
- Rebuilds configuration from scratch (no artifact reuse for safety)
- Applies changes to Kong Konnect
