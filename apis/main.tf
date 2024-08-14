resource "google_project_service" "service" {
    for_each = var.services_list

    project = var.project_id
    service = each.value

    timeouts {
        create = "30m"
        update = "40m"
    }

    disable_dependent_services = true
}