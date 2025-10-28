include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//_envcommon//project.hcl"
  expose = true
}

inputs = {
  auto_create_network = false
  additional_apis = [
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com"
  ]
  additional_labels = {
    purpose = "development"
    auto_shutdown = "true"
    backup_required = "false"
  }
}