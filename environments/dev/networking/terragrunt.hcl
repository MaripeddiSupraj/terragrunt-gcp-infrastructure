include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/networking.hcl"
  expose = true
}

inputs = {
  additional_tags = {
    purpose = "development"
    auto_shutdown = "true"
  }
}