resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.subnet_name

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  network_policy {
    enabled = var.enable_network_policy
  }

  monitoring_config {
    enable_components = var.enable_monitoring ? ["SYSTEM_COMPONENTS", "WORKLOADS"] : []
  }

  logging_config {
    enable_components = var.enable_logging ? ["SYSTEM_COMPONENTS", "WORKLOADS"] : []
  }
}

resource "google_container_node_pool" "primary_nodes" {
  for_each   = { for pool in var.node_pools : pool.name => pool }
  name       = each.value.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  project    = var.project_id
  node_count = each.value.initial_node_count

  autoscaling {
    min_node_count = each.value.min_count
    max_node_count = each.value.max_count
  }

  node_config {
    preemptible  = each.value.preemptible
    machine_type = each.value.machine_type
    disk_size_gb = each.value.disk_size_gb
    disk_type    = each.value.disk_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_repair  = each.value.auto_repair
    auto_upgrade = each.value.auto_upgrade
  }
}