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
    cluster_endpoint = "https://mock-endpoint"
  }
}

inputs = {
  app_name  = "frontend"
  namespace = "ecommerce-prod"
  image     = "nginx:latest"
  port      = 80
  replicas  = 3
  
  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "1000m"
      memory = "1Gi"
    }
  }
  
  env_vars = {
    NODE_ENV = "production"
    API_URL  = "http://backend-api"
  }
  
  health_check = {
    path                  = "/"
    port                  = 80
    initial_delay_seconds = 30
    period_seconds        = 10
  }
}