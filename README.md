# Kontfix Examples

This repository demonstrates how to use a CI/CD pipeline to manage [Kong Konnect](https://cloud.konghq.com/) control plane with the Nix module [Kontfix](https://github.com/liyangau/kontfix) and Terraform.

## About this repository

This example demonstrates:
- How to configure the Kong Konnect control plane using the Kontfix Nix module.
- Automated CI/CD workflows.

## How to use

1. Review the configuration files in the `konnect/` folder.
2. Custom plugin schemas **must** be stored in `custom-plugin-schemas/` at the root level.
3. This example breaks up control planes per region per file.
4. Understand how to set defaults configurations for all control planes and individual overrides.
5. Check the workflow files to see how configurations are built and applied. The workflows runs on my self-hosted runner, these actions should also work for Github runners or your own runners.
