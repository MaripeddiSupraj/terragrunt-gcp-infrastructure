include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//_envcommon//database.hcl"
  expose = true
}

inputs = {
  skip_final_snapshot = true
  copy_tags_to_snapshot = false
  master_password = "dev-password-123"
  auto_minor_version_upgrade = true
  apply_immediately = true
  storage_type = "gp2"
}