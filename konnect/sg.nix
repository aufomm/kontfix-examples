{ ... }:
let
  commonLabels = {
    environment = "dev";
    team = "candy";
  };
in
{
  kontfix = {
    controlPlanes = {
      sg = {
        timtam = {
          auth_type = "pinned_client_certs";
          create_certificate = true;
          cluster_type = "CLUSTER_TYPE_K8S_INGRESS_CONTROLLER";
        };
        marshmallow = {
          labels = commonLabels;
          create_certificate = true;
        };
        chocolate = {
          labels = commonLabels;
          create_certificate = true;
        };
      };
    };
    groups = {
      sg = {
        dev_team = {
          members = [
            "marshmallow"
            "chocolate"
          ];
          generate_token = true;
          storage_backend = [ "hcv" ];
        };
      };
    };
  };
}
