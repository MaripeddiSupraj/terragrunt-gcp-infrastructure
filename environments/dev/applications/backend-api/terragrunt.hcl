include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/gke-workload"
}

dependency "gke" {
  config_path = "../../gke-cluster"
  mock_outputs = {
    cluster_name = "mock-cluster"
  }
}

dependency "database" {
  config_path = "../../database"
  mock_outputs = {
    private_ip_address = "10.0.0.100"
  }
}

inputs = {
  app_name  = "backend-api"
  namespace = "ecommerce-dev"
  image     = "node:18-alpine"
  port      = 8080
  replicas  = 1
  
  resources = {
    requests = {
      cpu    = "200m"
      memory = "256Mi"
    }
    limits = {
      cpu    = "1000m"
      memory = "1Gi"
    }
  }
  
  env_vars = {
    NODE_ENV      = "development"
    DATABASE_HOST = dependency.database.outputs.private_ip_address
    DATABASE_NAME = "ecommerce"
    DATABASE_USER = "app_user"
    LOG_LEVEL     = "debug"
  }
  
  health_check = {
    path                  = "/health"
    port                  = 8080
    initial_delay_seconds = 60
    period_seconds        = 10
  }
}