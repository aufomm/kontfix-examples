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
        marshmallow = {
          labels = commonLabels;
          create_certificate = true;
          upload_ca_certificate = true;
        };
        chocolate = {
          labels = commonLabels;
          create_certificate = true;
          upload_ca_certificate = true;
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
