locals {
  path_parts = split("/", path_relative_to_include())
  environment = local.path_parts[1]
  
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  org_vars = read_terragrunt_config(find_in_parent_folders("organization.hcl"))
  
  common_labels = {
    environment = local.environment
    managed_by = "terragrunt"
    project = "ecommerce-platform"
    team = "devops"
    cost_center = local.env_vars.locals.cost_center
    compliance = local.env_vars.locals.compliance_level
  }
}

remote_state {
  backend = "gcs"
  config = {
    bucket = "${local.org_vars.locals.state_bucket_prefix}-${local.org_vars.locals.organization_id}-${local.environment}"
    prefix = "${path_relative_to_include()}/terraform.tfstate"
    enable_bucket_policy_only = true
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "${local.env_vars.locals.project_id}"
  region = "${local.region_vars.locals.gcp_region}"
  zone = "${local.region_vars.locals.gcp_zone}"
  default_labels = ${jsonencode(local.common_labels)}
}

provider "google-beta" {
  project = "${local.env_vars.locals.project_id}"
  region = "${local.region_vars.locals.gcp_region}"
  zone = "${local.region_vars.locals.gcp_zone}"
  default_labels = ${jsonencode(local.common_labels)}
}
EOF
}

inputs = merge(
  local.org_vars.locals,
  local.region_vars.locals,
  local.env_vars.locals,
  {
    environment = local.environment
    common_labels = local.common_labels
  }
)