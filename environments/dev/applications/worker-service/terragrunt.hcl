include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/gke-workload"
}

dependency "database" {
  config_path = "../../database"
  mock_outputs = {
    private_ip_address = "10.0.0.100"
  }
}

inputs = {
  app_name  = "worker-service"
  namespace = "ecommerce-dev"
  image     = "python:3.11-slim"
  port      = 8000
  replicas  = 1
  
  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
  }
  
  env_vars = {
    ENVIRONMENT   = "development"
    DATABASE_HOST = dependency.database.outputs.private_ip_address
    DATABASE_NAME = "ecommerce"
    WORKER_TYPE   = "background"
    LOG_LEVEL     = "debug"
  }
  
  health_check = {
    path                  = "/health"
    port                  = 8000
    initial_delay_seconds = 30
    period_seconds        = 15
  }
}