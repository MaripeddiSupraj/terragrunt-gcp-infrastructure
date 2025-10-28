locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

terraform {
  source = "../../../modules/networking"
}

# Using existing project directly

inputs = {
  project_id = "green-cell-474517-d5"
  vpc_name = "${local.env_vars.locals.environment}-vpc"
  vpc_cidr = local.region_vars.locals.vpc_cidr
  
  subnets = [
    {
      name = "${local.env_vars.locals.environment}-public-subnet"
      cidr = cidrsubnet(local.region_vars.locals.vpc_cidr, 8, 1)
      region = local.region_vars.locals.gcp_region
      private_ip_google_access = local.region_vars.locals.enable_private_google_access
    },
    {
      name = "${local.env_vars.locals.environment}-private-subnet"
      cidr = cidrsubnet(local.region_vars.locals.vpc_cidr, 8, 2)
      region = local.region_vars.locals.gcp_region
      private_ip_google_access = local.region_vars.locals.enable_private_google_access
    }
  ]
  
  secondary_ranges = {
    "${local.env_vars.locals.environment}-private-subnet" = [
      {
        range_name = "gke-pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name = "gke-services"
        ip_cidr_range = "192.168.64.0/18"
      }
    ]
  }
  
  firewall_rules = [
    {
      name = "${local.env_vars.locals.environment}-allow-internal"
      direction = "INGRESS"
      allow = [
        {
          protocol = "tcp"
          ports = ["0-65535"]
        }
      ]
      source_ranges = [local.region_vars.locals.vpc_cidr]
    }
  ]
  
  enable_flow_logs = local.region_vars.locals.enable_flow_logs
}