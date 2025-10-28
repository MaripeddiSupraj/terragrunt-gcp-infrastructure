locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/cloud-sql"
}

dependency "project" {
  config_path = "../project"
  mock_outputs = {
    project_id = "mock-project-id"
  }
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    vpc_self_link = "mock-vpc-link"
    private_vpc_connection = "mock-connection"
  }
}

inputs = {
  project_id = dependency.project.outputs.project_id
  region = local.region_vars.locals.gcp_region
  instance_name = "${local.env_vars.locals.environment}-postgres"
  database_version = "POSTGRES_15"
  tier = local.env_vars.locals.db_tier
  disk_size = local.env_vars.locals.db_disk_size
  disk_type = "PD_SSD"
  
  availability_type = local.env_vars.locals.db_high_availability ? "REGIONAL" : "ZONAL"
  backup_enabled = local.env_vars.locals.db_backup_enabled
  backup_start_time = "03:00"
  
  vpc_network = dependency.networking.outputs.vpc_self_link
  private_network = dependency.networking.outputs.private_vpc_connection
  deletion_protection = local.env_vars.locals.db_deletion_protection
  
  databases = [
    {
      name = "ecommerce"
      charset = "UTF8"
      collation = "en_US.UTF8"
    }
  ]
  
  users = [
    {
      name = "app_user"
      password = "change-me-in-production"
    }
  ]
}