include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}//_envcommon//gke.hcl"
  expose = true
}

inputs = {
  remove_default_node_pool = true
  enable_binary_authorization = false
  enable_shielded_nodes = false
  horizontal_pod_autoscaling = true
  http_load_balancing = true
  network_policy_config = false
}