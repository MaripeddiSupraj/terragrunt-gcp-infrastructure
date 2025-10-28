output "project_id" {
  description = "The project ID"
  value       = data.google_project.project.project_id
}

output "project_number" {
  description = "The project number"
  value       = data.google_project.project.number
}

output "terraform_service_account_email" {
  description = "The email of the Terraform service account"
  value       = google_service_account.terraform.email
}