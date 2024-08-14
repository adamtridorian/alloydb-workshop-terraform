resource "google_workbench_instance" "workbench-instance" {
  name     = "workbench-instance"
  location = "asia-southeast1-a"
  project  = var.project_id
  gce_setup {
    machine_type = "e2-standard-2"
  }
}