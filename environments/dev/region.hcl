locals {
  gcp_region = "us-central1"
  gcp_zone = "us-central1-a"
  zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  vpc_cidr = "10.0.0.0/16"
  enable_private_google_access = true
  enable_flow_logs = false
}