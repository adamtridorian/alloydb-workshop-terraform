locals {
  iam_list = {
    for x in var.iam_list :
    "${x.role}/${x.role}" => x
  }
}

resource "google_project_iam_binding" "project" {
  for_each = local.iam_list
  project = var.project_id
  role    = each.value.role

  members = each.value.member
}

data "google_bigquery_default_service_account" "bq_sa" {
}

data "google_project" "current" {
  project_id = var.project_id
}

output "project_number" {
  value = data.google_project.current.number
}

resource "google_project_iam_member" "bigquery_aiplatform_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${data.google_bigquery_default_service_account.bq_sa.email}"
}

data "google_compute_default_service_account" "default" {
}

resource "google_project_iam_member" "compute_service_account_iam_admin" {
  project = var.project_id
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${data.google_compute_default_service_account.default.email}"
}

resource "google_project_iam_member" "alloydb_aiplatform_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-alloydb.iam.gserviceaccount.com"
}