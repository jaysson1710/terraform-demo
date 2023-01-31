
variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine"
  default     = "Administrator"
  validation {
    condition     = length(var.admin_username) >= 8
    error_message = "Longitud minima 8."
  }
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements"
  validation {
    condition     = length(var.admin_password) >= 10
    error_message = "Longitud password inseguro, longitud minima 10."
  }
  validation {
    condition     = can(regex("(.*[A-Z])+(.*[a-z])+(.*[0-9])+(.*[.#-@!¡?+*])", var.admin_password))
    error_message = "Manejo de password inseguro."
  }
}

variable "location" {
  type        = string
  description = "Localización de los recursos a desplegar."
}

variable "connection_db" {
  type        = string
  description = "cadena conexion db"
}

variable "rg" {
  description = "Nombre del grupo de recursos."
}

variable "subnet" {
  description = "identificador de la subnet a configurar"
}

variable "vmSize" {
  type        = string
  default     = "Standard_DS1_v2"
  description = "Tamaño de VM permitidos: Standard_DS1_v2,Standard_B1ms,Standard_D2s_v3,Standard_B4ms,Standard_D8s_V3."
  validation {
    condition     = contains(["Standard_DS1_v2", "Standard_B1ms", "Standard_D2s_v3", "Standard_B4ms", "Standard_D8s_V3"], var.vmSize)
    error_message = "Tamaño de VM permitidos: \n Standard_DS1_v2 \n Standard_B1ms \n Standard_D2s_v3 \n Standard_B4ms \n Standard_D8s_V3."
  }
}

variable "vmName" {
  type    = string
  default = "myTFVM"
}

variable "managed_disk_type" {
  type        = string
  description = "Tipos de discos pa VM permitidos: Premium_LRS, Standard_LRS."
  validation {
    condition     = contains(["Premium_LRS", "Standard_LRS"], var.managed_disk_type)
    error_message = "Tipos de discos pa VM permitidos: Premium_LRS, Standard_LRS."
  }
}


variable "image_reference" {
  type        = string
  description = "Referencia de imagenes para vm permitidas: \n WindowsServer|MicrosoftWindowsServer|2019-Datacenter \n WindowsServer|MicrosoftWindowsServer|2016-Datacenter \n UbuntuServer|Canonical|18.04-LTS \n SLES|SUSE|15 \n RHEL|RedHat|7-LVM \n debian-10|Debian|10 \n oracle-database-19-3|Oracle|oracle-database-19-0904"
  validation {
    condition     = contains(["WindowsServer|MicrosoftWindowsServer|2019-Datacenter", "WindowsServer|MicrosoftWindowsServer|2016-Datacenter", "UbuntuServer|Canonical|18.04-LTS", "SLES|SUSE|15", "RHEL|RedHat|7-LVM", "debian-10|Debian|10", "oracle-database-19-3|Oracle|oracle-database-19-0904"], var.image_reference)
    error_message = "Referencia de imagenes para vm permitidas: \n WindowsServer|MicrosoftWindowsServer|2019-Datacenter \n WindowsServer|MicrosoftWindowsServer|2016-Datacenter \n UbuntuServer|Canonical|18.04-LTS \n SLES|SUSE|15 \n RHEL|RedHat|7-LVM \n debian-10|Debian|10 \n oracle-database-19-3|Oracle|oracle-database-19-0904."
  }
}

variable "tags" {
  type = map(any)
  default = {
    Environment = "dev"
    Area        = "desarrollo"
  }
}

locals {
  referencia = split("|", var.image_reference)
  offer      = element(local.referencia, 0)
  publisher  = element(local.referencia, 1)
  sku        = element(local.referencia, 2)
}