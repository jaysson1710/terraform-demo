variable "location" {
  default = "eastus"
  description = "Localización de los recursos a desplegar."
  validation{
    condition = contains(["westus", "eastus"], var.location)
    error_message = "El nombre seleccionado para el grupo de recursos no cumple con los estandares organizaciones, ejemplo de nombre valido RG-EAU-ECP-DEV-ejemplodf12."
  }
}

variable "resourcegroup" {
  type = string
  default =  "RG-EAU-ECP-DEV-ejemplo"
  description = "Nombre del grupo de recursos."
  validation{
    condition = can(regex("RG-(EAU|AWU|ASC|ABS)-(ECP|EAI|EMX|RFC)-(DEV|QAS|UAT|PRD|BCK|SHD)-(.*[A-Za-z0-9-_])",var.resourcegroup))
    error_message = "El nombre seleccionado para el grupo de recursos no cumple con los estandares organizaciones, ejemplo de nombre valido RG-EAU-ECP-DEV-ejemplodf12."
  }
}

variable "tags" {
  type = map
  default = {
    Environment = "dev"
    Area        = "desarrollo"
  }
}

