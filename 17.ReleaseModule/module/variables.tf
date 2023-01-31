variable "nombre_storage" {
  default = "storageaccountejemplo2"
  description = "Nombre del storage account"
  validation{
    condition = can(regex("(.*[a-z0-9])",var.nombre_storage))
    error_message = "El nombre seleccionado para el Storage Account no cumple con los estandares organizacionales."
  }
}

variable "location" {
    type = string
    description = "(optional) describe your variable"
}

variable "rg" {
    description = "Grupo de recurosos"
}

variable "tags" {
  type = map
  default = {
    Environment = "dev"
    Area        = "desarrollo"
  }
}

### 
variable "account_replication_type" {
    type = string
    default = "LRS"
    description = "Deployment environment LRS,GRS"
    validation {
        condition = contains(["LRS", "GRS"], var.account_replication_type)
        error_message = "Valid value is one of the following: LRS,GRS."
    }
}

variable "account_tier" {
  type = string
  default = "Standard"
  description = "Deployment environment Standard,Premium"
  validation {
    condition = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Valid value is one of the following: Standard,Premium."
  }
}