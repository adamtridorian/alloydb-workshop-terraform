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
    "bigquery.googleapis.com",
  ]
}

#VPC
module "vpc" {
  source       = "./vpc"
  project_id   = var.project_id
  network_name = "data-lab-vpc"
  depends_on   = [module.apis]
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
    },
    {
      role   = "roles/aiplatform.user"
      member = var.viewer_emails
    },
    {
      role   = "roles/bigquery.connectionAdmin"
      member = var.viewer_emails
    },
    {
      role   = "roles/bigquery.dataEditor"
      member = var.viewer_emails
    },
    {
      role   = "roles/bigquery.user"
      member = var.viewer_emails
    }
  ]
  depends_on = [module.apis]
}

#AlloyDB
module "alloydb" {
  source           = "./alloydb"
  project_id       = module.apis.project_id
  vpc_network_name = module.vpc.vpc_name
  depends_on       = [module.apis]
}

#Vertex AI Workbench
module "vertex_ai" {
  source           = "./vertex_ai"
  project_id       = module.apis.project_id
  vpc_network_name = module.vpc.vpc_self_link
  depends_on       = [module.apis]
  unique_emails    = local.unique_emails
}

#BigQuery
module "big_query" {
  source     = "./big_query"
  project_id = module.apis.project_id
  depends_on = [module.apis]
}

