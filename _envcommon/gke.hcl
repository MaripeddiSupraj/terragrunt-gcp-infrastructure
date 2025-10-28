locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules/gke-cluster"
}

dependency "project" {
  config_path = "../project"
  mock_outputs = {
    project_id = "mock-project-id"
  }
}

dependency "networking" {
  config_path = "../networking"
  mock_outputs = {
    vpc_name = "mock-vpc"
    private_subnet_name = "mock-subnet"
    pods_range_name = "gke-pods"
    services_range_name = "gke-services"
  }
}

inputs = {
  project_id = dependency.project.outputs.project_id
  cluster_name = "${local.env_vars.locals.environment}-gke-cluster"
  region = local.region_vars.locals.gcp_region
  zones = local.region_vars.locals.zones
  
  vpc_name = dependency.networking.outputs.vpc_name
  subnet_name = dependency.networking.outputs.private_subnet_name
  pods_range_name = dependency.networking.outputs.pods_range_name
  services_range_name = dependency.networking.outputs.services_range_name
  
  node_pools = [
    {
      name = "default-pool"
      machine_type = local.env_vars.locals.gke_machine_type
      min_count = local.env_vars.locals.gke_min_node_count
      max_count = local.env_vars.locals.gke_max_node_count
      initial_node_count = local.env_vars.locals.gke_node_count
      disk_size_gb = local.env_vars.locals.gke_disk_size_gb
      disk_type = "pd-standard"
      preemptible = local.env_vars.locals.gke_preemptible
      auto_upgrade = local.env_vars.locals.enable_node_auto_upgrade
      auto_repair = true
    }
  ]
  
  enable_network_policy = local.env_vars.locals.enable_network_policy
  enable_cluster_autoscaling = local.env_vars.locals.enable_cluster_autoscaling
  enable_private_nodes = true
  master_ipv4_cidr_block = "172.16.0.0/28"
  enable_monitoring = local.env_vars.locals.enable_monitoring
  enable_logging = true
}