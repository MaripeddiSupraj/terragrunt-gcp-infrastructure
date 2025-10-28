resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  org_id          = var.organization_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
  labels          = var.common_labels
}

resource "google_project_service" "apis" {
  for_each = toset(concat(var.enable_apis, var.additional_apis))
  project  = google_project.project.project_id
  service  = each.value
  disable_dependent_services = true
  disable_on_destroy = false
}

resource "google_service_account" "terraform" {
  project      = google_project.project.project_id
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
  description  = "Service account for Terraform operations"
  depends_on   = [google_project_service.apis]
}

resource "google_project_iam_member" "terraform_roles" {
  for_each = toset([
    "roles/editor",
    "roles/iam.serviceAccountAdmin",
    "roles/resourcemanager.projectIamAdmin"
  ])
  project = google_project.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform.email}"
}