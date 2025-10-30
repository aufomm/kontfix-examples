{
  kontfix = {
    controlPlanes = {
      eu = {
        dev = {
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
      };
    };
  };
}
