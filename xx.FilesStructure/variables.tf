
variable "name" {
    type = string
    description = "Name resource group"
}
variable "location" {
    type = string
    description = "Resources location"
}

variable "tags" {
  type = map
  description = "Environment Tags"
}