locals {
  environment = "dev"
  project_id = "green-cell-474517-d5"
  cost_center = "development"
  compliance_level = "basic"
  
  # GKE settings
  gke_node_count = 1
  gke_min_node_count = 1
  gke_max_node_count = 3
  gke_machine_type = "e2-medium"
  gke_disk_size_gb = 50
  gke_preemptible = true
  
  # Database settings
  db_tier = "db-f1-micro"
  db_disk_size = 20
  db_backup_enabled = false
  db_high_availability = false
  db_deletion_protection = false
  
  # Features
  enable_monitoring = true
  log_retention_days = 7
  enable_network_policy = false
  enable_cluster_autoscaling = true
  enable_node_auto_upgrade = true
}