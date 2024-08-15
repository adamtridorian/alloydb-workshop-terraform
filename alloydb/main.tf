resource "google_alloydb_instance" "alloydb-instance" {
  cluster       = google_alloydb_cluster.alloydb-cluster.id
  instance_id   = "alloydb-instance"
  instance_type = "PRIMARY"

  machine_config {
    cpu_count = 2
  }

  network_config {
    enable_public_ip = true
  }

  depends_on = [google_service_networking_connection.vpc_connection]
}

resource "google_alloydb_cluster" "alloydb-cluster" {
  cluster_id = "alloydb-cluster"
  location   = "asia-southeast"
  project    = var.project_id

  network_config {
    network = var.vpc_network_name
  }

  initial_user {
    password = "alloydb-cluster"
  }
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "alloydb-cluster"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  network       = "data-lab-vpc"
}

resource "google_service_networking_connection" "vpc_connection" {
  network                 = var.vpc_network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}