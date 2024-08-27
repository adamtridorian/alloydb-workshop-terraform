variable "project_id" {
  type = string
  description = "Project to be assigned IAM"
}

variable "iam_list" {
  type        = list(object({role = string, member = list(string)}))
  description = "List of IAM"
  default     = []   
}
