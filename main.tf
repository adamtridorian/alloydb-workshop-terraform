terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.40.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

#API Services
module "apis" {
  source     = "./apis"
  project_id = var.project_id
  services_list = [
    "alloydb.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
    "iam.googleapis.com",
    "notebooks.googleapis.com",
    "bigquery.googleapis.com"
  ]
}

#User IAM
module "user_iam" {
  source     = "./user_iam"
  project_id = module.apis.project_id
  iam_list = [
    {
      role   = "roles/viewer"
      member = var.viewer_emails
    },
    {
      role   = "roles/editor"
      member = var.editor_emails
    }
  ]
}

#AlloyDB
module "alloydb" {
  source     = "./alloydb"
  project_id = module.apis.project_id
}

#Vertex AI Workbench
module "vertex_ai" {
  source     = "./vertex_ai"
  project_id = module.apis.project_id
}

#BigQuery
module "big_query" {
  source     = "./big_query"
  project_id = module.apis.project_id
}

