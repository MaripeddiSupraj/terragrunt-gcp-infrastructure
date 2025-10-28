include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/static-ip"
}

dependency "project" {
  config_path = "../project"
  mock_outputs = {
    project_id = "mock-project-id"
  }
}

inputs = {
  project_id = dependency.project.outputs.project_id
  ip_name    = "dev-frontend-ip"
}