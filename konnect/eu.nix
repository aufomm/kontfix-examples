{
  kontfix = {
    controlPlanes = {
      eu = {
        dev-cluster = {
          auth_type = "pinned_client_certs";
          create_certificate = true;
          upload_ca_certificate = true;
          cluster_type = "CLUSTER_TYPE_K8S_INGRESS_CONTROLLER";
        };
        dev = {
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        stg = {
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        platform = {
          system_account = {
            enable = true;
            generate_token = true;
          };
        };
        dev-cpg = {
          auth_type = "pinned_client_certs";
          create_certificate = true;
          upload_ca_certificate = true;
          cluster_type = "CLUSTER_TYPE_CONTROL_PLANE_GROUP";
          members = [
            "dev"
            "platform"
          ];
        };
        dev-stg = {
          auth_type = "pinned_client_certs";
          create_certificate = true;
          upload_ca_certificate = true;
          cluster_type = "CLUSTER_TYPE_CONTROL_PLANE_GROUP";
          members = [
            "stg"
            "platform"
          ];
        };
      };
    };
  };
}
