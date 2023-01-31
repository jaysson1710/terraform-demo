
variable "pass_vm" {
  type        = string
  description = "(optional) describe your variable"
  sensitive   = true
  default     = "Password1234!"
}

variable "user_vm" {
  type        = string
  default     = "usuario_test"
  description = "Usuario admin vm"
}

variable "functionname" {
  type        = string
  description = "Nombre de la funcion linux"
  default     = "fn-test25"
}
variable "resource_group" {
  type    = string
  default = "RG-demo"
}

variable "vnet_dir" {
  default     = "10.0.0.0/16"
  type        = string
  description = "Espacio de direcciones usado para la red"
}
variable "vnet_name" {
  type        = string
  default     = "VN_XX"
  description = "Nombre de la red"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "tags" {
  type = map(string)
  default = {
    env      = "dev"
    bussines = "demo"
  }
}

variable "user_db" {
  type        = string
  default     = "missadministrator"
  description = "Nombre de usuario admin DB"
}

variable "pass_db" {
  type        = string
  sensitive   = true
  default     = "thisIsKat11"
  description = "Pass usuario admin DB"
}

############# local ############################

locals {
  subnets = cidrsubnets(var.vnet_dir, 8, 8)
}

locals {
  rules = [{
    name                       = "SSH"
    priority                   = 123
    direction                  = "Inbound"
    access                     = "Allow"
    source_port_range          = "*"
    protocol                   = "Tcp"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    }, {
    name                       = "HTTP"
    priority                   = 124
    direction                  = "Inbound"
    access                     = "Allow"
    source_port_range          = "*"
    protocol                   = "Tcp"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }]

}