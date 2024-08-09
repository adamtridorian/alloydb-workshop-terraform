terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

#API Services
resource "google_project_services" "project_services" {
  project = var.project_id
  services = [
    "alloydb.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "iam.googleapis.com",
    "notebooks.googleapis.com",
    "bigquery.googleapis.com"
  ]

  timeouts {
    create = "30m"
    update = "40m"
  }
}

#AlloyDB
resource "google_alloydb_instance" "alloydb-instance" {
  cluster       = google_alloydb_cluster.alloydb-cluster.id
  instance_id   = "alloydb-instance"
  instance_type = "PRIMARY"

  machine_config {
    cpu_count = 2
  }

  depends_on = [google_service_networking_connection.vpc_connection]
}

resource "google_alloydb_cluster" "alloydb-cluster" {
  cluster_id = "alloydb-cluster"
  location   = "asia-southeast1"

  network_config {
    network = "default"  # Use the default VPC
  }

  initial_user {
    password = "alloydb-cluster"
  }
}

data "google_project" "project" {}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "alloydb-cluster"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  network       = "default"  # Use the default VPC
}

resource "google_service_networking_connection" "vpc_connection" {
  network                 = "default"  # Use the default VPC
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

#Workbench
resource "google_workbench_instance" "workbench-instance" {
  name = "workbench-instance"
  location = "asia-southeast1-a"
  gce_setup {
    machine_type = "e2-standard-2"
  }
}

#BigQuery
resource "google_bigquery_dataset" "bq-dataset" {
  dataset_id = "bq_dataset"
  project    = var.project_id
  location   = "asia-southeast1"
}

resource "google_bigquery_table" "bq-table" {
  table_id = "bq-table"
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id

  schema = jsonencode([
    {
      "name" = "name"
      "type" = "STRING"
      "mode" = "NULLABLE"
    },
    {
      "name" = "age"
      "type" = "INTEGER"
      "mode" = "NULLABLE"
    }
  ])
}

