variable "azure_region" {
    description = "The Azure region to deploy resources in"
    type        = string
    default     = "westeurope"
}
variable "vmname" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "VMadmin" {
  description = "The admin username of the Virtual Machine"
  type        = string
}

variable "VMpassword" {
  description = "The admin password of the Virtual Machine"
  type        = string
  sensitive   = true
}