{ ... }:
let
  commonLabels = {
    environment = "homelab";
  };
in
{
  kontfix = {
    controlPlanes = {
      au = {
        rock = {
          description = "Control plane used by rock team";
          create_certificate = true;
          custom_plugins = [ "path-prefix" ];
          labels = commonLabels;
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        lxc = {
          description = "Control plane used to in lxc container";
          create_certificate = true;
          labels = commonLabels;
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        exp = {
          description = "Control plane used to in local machine";
          create_certificate = true;
          labels = {
            environment = "local";
          };
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        k0s = {
          description = "Control plane used for k0s cluster";
          create_certificate = true;
          auth_type = "pinned_client_certs";
          cluster_type = "CLUSTER_TYPE_K8S_INGRESS_CONTROLLER";
          labels = {
            environment = "local";
            platform = "kubernetes";
          };
        };
      };
    };
  };
}
