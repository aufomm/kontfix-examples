{
  description = "Kong Konnect Infrastructure";

  inputs = {
    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    kontfix.url = "github:liyangau/kontfix";
  };

  outputs =
    {
      self,
      nixpkgs-terraform,
      nixpkgs,
      systems,
      kontfix,
    }:
    let
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          f {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
      tf_version = "terraform-1.13.4";
      terraformConfiguration =
        system:
        kontfix.lib.kontfixConfiguration {
          inherit system;
          modules = [
            ./konnect/default.nix
            ./konnect/us.nix
            ./konnect/eu.nix
            ./konnect/sg.nix
            ./konnect/s3-state.nix
          ];
        };
    in
    {
      apps = forEachSystem (
        { system, pkgs }:
        let
          terraform = nixpkgs-terraform.packages.${system}.${tf_version};
          config = terraformConfiguration system;
          
          # Helper to create terraform commands
          mkTerraformApp = name: cmd: {
            type = "app";
            program = toString (
              pkgs.writers.writeBash name ''
                set -euo pipefail
                if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
                cp ${config} config.tf.json
                ${terraform}/bin/terraform ${cmd} "$@"
              ''
            );
          };
        in
        {
          # Individual commands (for local use)
          build = {
            type = "app";
            program = toString (
              pkgs.writers.writeBash "build" ''
                if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
                cp ${config} config.tf.json
              ''
            );
          };
          
          init = mkTerraformApp "init" "init";
          plan = mkTerraformApp "plan" "plan";
          apply = mkTerraformApp "apply" "apply";
          destroy = mkTerraformApp "destroy" "destroy";
          show = mkTerraformApp "show" "show";
          validate = mkTerraformApp "validate" "validate";
          
          # CI workflow apps (combines multiple steps for speed)
          ci-plan = {
            type = "app";
            program = toString (
              pkgs.writers.writeBash "ci-plan" ''
                set -euo pipefail
                echo "::group::Building Terraform configuration"
                if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
                cp ${config} config.tf.json
                echo "::endgroup::"
                
                echo "::group::Terraform init"
                ${terraform}/bin/terraform init
                echo "::endgroup::"
                
                echo "::group::Terraform plan"
                ${terraform}/bin/terraform plan -out=tfplan
                echo "::endgroup::"
                
                echo "::group::Converting plan to JSON"
                ${terraform}/bin/terraform show -json tfplan > plan.json
                echo "::endgroup::"
              ''
            );
          };
          
          ci-apply = {
            type = "app";
            program = toString (
              pkgs.writers.writeBash "ci-apply" ''
                set -euo pipefail
                echo "::group::Building Terraform configuration"
                if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
                cp ${config} config.tf.json
                echo "::endgroup::"
                
                echo "::group::Terraform init"
                ${terraform}/bin/terraform init
                echo "::endgroup::"
                
                echo "::group::Terraform plan"
                ${terraform}/bin/terraform plan -out=tfplan
                echo "::endgroup::"
                
                echo "::group::Terraform apply"
                ${terraform}/bin/terraform apply -auto-approve tfplan
                echo "::endgroup::"
              ''
            );
          };
        }
      );

      devShells = forEachSystem (
        { system, pkgs }:
        let
          terraform = nixpkgs-terraform.packages.${system}.${tf_version};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [ terraform ];
          };
        }
      );
    };
}