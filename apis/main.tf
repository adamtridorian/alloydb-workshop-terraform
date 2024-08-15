resource "google_project_service" "project_services" {
    for_each = var.services_list

    project = var.project_id
    service = each.value

    timeouts {
        create = "30m"
        update = "40m"
    }
    
    disable_on_destroy = false
}