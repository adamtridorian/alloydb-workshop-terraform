resource "google_workbench_instance" "workbench-instance" {
  name     = "workbench-instance1"
  location = "asia-southeast1-a"
  project  = var.project_id
  gce_setup {
    machine_type = "e2-standard-2"

    network_interfaces {
      network = var.vpc_network_name
    }
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}