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
      };
    };
  };
}
