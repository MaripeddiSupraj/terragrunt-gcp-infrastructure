locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  org_vars = read_terragrunt_config(find_in_parent_folders("organization.hcl"))
}

terraform {
  source = "../../../modules/gcp-project"
}

inputs = {
  project_id = local.env_vars.locals.project_id
  project_name = "E-commerce ${title(local.env_vars.locals.environment)}"
  # organization_id = local.org_vars.locals.organization_id
  # billing_account = local.org_vars.locals.billing_account
  # folder_id = local.org_vars.locals.folder_id
  
  enable_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "servicenetworking.googleapis.com",
    "dns.googleapis.com"
  ]
  
  enable_audit_logs = local.org_vars.locals.enable_audit_logs
  audit_log_retention_days = local.org_vars.locals.audit_log_retention_days
}