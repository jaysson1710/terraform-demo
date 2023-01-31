terraform {
  
}


variable "admin_username" {
    type = string
    description = "Administrator user name for virtual machine"
}

variable "admin_password" {
    type = string
    description = "Password must meet Azure complexity requirements"
    sensitive = true
    validation {
        condition = length(var.admin_password) >= 10
        error_message = "Longitud password inseguro, longitud minima 10."
    }
    validation {
        condition = can(regex("(.*[A-Z])+(.*[a-z])+(.*[0-9])+(.*[.#-@!¡?+*])",var.admin_password))
        error_message = "Manejo de password inseguro."
    }
}

variable "sku" {
    type = string
    description = "(optional) describe your variable"
    validation {
      condition = contains(["GP_Gen4", "GP_Gen5", "BC_Gen4", "BC_Gen5"], var.sku)
      error_message = "Tipos de SKU permitidos: GP_Gen4, GP_Gen5, BC_Gen4, BC_Gen5."
    }
}