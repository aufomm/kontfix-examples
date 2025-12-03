{
  kontfix = {
    defaults = {
      pki_ca_certificate = builtins.readFile ./pki-ca/ca.pem;
      system_account_tokens = {
        validity_period = 7;
        renewal_before_expiry = 3;
      };
      vault_pki.ttl = "720h";
      storage = {
        hcv = {
          address = "https://vault.li.lab:8200";
          auth_method = "approle";
        };
      };
      pki = {
        hcv = {
          address = "https://vault.li.lab:8200";
          auth_method = "approle";
        };
      };
      controlPlanes = {
        auth_type = "pki_client_certs";
        storage_backend = [ "hcv" ];
        labels = {
          generator = "kontfix";
        };
      };
    };
  };
}
