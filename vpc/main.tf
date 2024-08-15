resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = true
  project                 = var.project_id
  routing_mode            = "REGIONAL"
}