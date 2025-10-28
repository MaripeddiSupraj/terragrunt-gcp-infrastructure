locals {
  environment = "prod"
  project_id = "ecommerce-prod-project"
  cost_center = "production"
  compliance_level = "strict"
  
  # GKE settings
  gke_node_count = 3
  gke_min_node_count = 3
  gke_max_node_count = 10
  gke_machine_type = "n2-standard-4"
  gke_disk_size_gb = 50
  gke_preemptible = false
  
  # Database settings
  db_tier = "db-custom-4-16384"
  db_disk_size = 100
  db_backup_enabled = true
  db_high_availability = true
  db_deletion_protection = true
  
  # Features
  enable_monitoring = true
  log_retention_days = 90
  enable_network_policy = true
  enable_cluster_autoscaling = true
  enable_node_auto_upgrade = false
}