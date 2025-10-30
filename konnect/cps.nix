{
  kontfix = {
    controlPlanes = {
      us = {
        dev = {
          description = "dev control plane";
          create_certificate = true;
          upload_ca_certificate = true;
          system_account = {
            enable = true;
            generate_token = true;
          };
          labels = {
            environment = "dev";
            team = "platform";
          };
        };
        stg = {
          name = "staging";
          description = "staging control plane";
          create_certificate = true;
          upload_ca_certificate = true;
          system_account = {
            enable = true;
            generate_token = true;
          };
          labels = {
            environment = "stg";
            team = "platform";
          };
        };
      };
    };
  };
}
