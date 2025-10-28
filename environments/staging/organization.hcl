locals {
  organization_id = "123456789012"
  billing_account = "ABCDEF-123456-ABCDEF"
  state_bucket_prefix = "ecommerce-terraform-state"
  folder_id = "folders/123456789012"
  
  enable_audit_logs = true
  enable_security_center = true
  backup_retention_days = 7
  audit_log_retention_days = 30
}