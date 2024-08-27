variable "project_id" {
  type          = string
  description   = "Project ID of GCP Project"
}

variable "vpc_network_name" {
  description = "The name of the VPC network to use."
  type        = string
}

variable "iam_list" {
  type        = list(object({role = string, member = list(string)}))
  description = "List of IAM"
  default     = []   
}

variable "unique_emails" {
  description = "Unique list of emails for Workbench instances"
  type        = set(string)
}