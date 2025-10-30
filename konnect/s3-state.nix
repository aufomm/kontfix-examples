{
  terraform.backend.s3 = {
    bucket = "kontfix";
    key = "gha/terraform.tfstate"; 
    region = "us-east-1";
    skip_credentials_validation = true;
    skip_region_validation = true;
    skip_requesting_account_id = true;
    skip_metadata_api_check = true;
    skip_s3_checksum = true;
    force_path_style = true;
  };
}
