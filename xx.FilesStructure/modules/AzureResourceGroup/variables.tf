variable "resource_group_name" {
    type = string

    validation {
        condition = length(var.resource_group_name) > 0
        error_message = "The name of the resource group must be specified."
    } 
}

variable "azure_location" {
    type = string

    validation {
        condition = length(var.azure_location) > 0
        error_message = "A valid Azure location must be specified."
    } 
}

variable "tags" {
  type = map
  description = "Environment Tags"
}