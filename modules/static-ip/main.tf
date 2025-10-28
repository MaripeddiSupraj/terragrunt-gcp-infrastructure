resource "google_compute_global_address" "static_ip" {
  name    = var.ip_name
  project = var.project_id
}