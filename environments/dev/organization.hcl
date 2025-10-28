locals {
  organization_id = ""
  billing_account = ""
  state_bucket_prefix = "ecommerce-terraform-state"
  folder_id = "folders/123456789012"
  
  enable_audit_logs = true
  enable_security_center = true
  backup_retention_days = 7
  audit_log_retention_days = 30
}