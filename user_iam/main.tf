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