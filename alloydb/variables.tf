variable "project_id" {
  type          = string
  description   = "Project ID of GCP Project"
}

variable "vpc_network_name" {
  description = "The name of the VPC network to use."
  type        = string
}