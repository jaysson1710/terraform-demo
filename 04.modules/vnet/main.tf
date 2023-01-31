variable "rg" {
  description = "Nombre del grupo de recursos"
}

variable "nombre_vnet" {
  description = "Nombre de la red a configurar"
  default = "VN-EAU-ECP-DEV-ejemplo"
  validation{
    condition = can(regex("VN-(EAU|AWU|ASC|ABS)-(ECP|EAI|EMX|RFC)-(DEV|QAS|UAT|PRD|BCK|SHD)-(.*[A-Za-z0-9-_])",var.nombre_vnet))
    error_message = "El nombre seleccionado para la vnet no cumple con los estandares organizacionales."
  }
}
variable "address_space_vnet" {
  description = "Espacio de direcciones disponible en la vnet"
  default = ["10.0.0.0/16"]
}
variable "nombre_subnet" {
  description = "Nombre de la subnet a configurar"
  default = "SN-EAU-ECP-DEV-ejemplo"
  validation{
    condition = can(regex("SN-(EAU|AWU|ASC|ABS)-(ECP|EAI|EMX|RFC)-(DEV|QAS|UAT|PRD|BCK|SHD)-(.*[A-Za-z0-9-_])",var.nombre_subnet))
    error_message = "El nombre seleccionado para la subnet no cumple con los estandares organizacionales."
  }
}
variable "address_space_subnet" {
  description = "Espacio de direcciones disponible en la subnet"
  default = ["10.0.1.0/24"]
}

variable "tags" {
  type = map
  default = {
    Environment = "dev"
    Area        = "desarrollo"
  }
}

variable "location" {
  default = "eastus"
}

locals {
  ngs = replace(var.nombre_subnet, "SN", "SG")
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.nombre_vnet
    address_space       = var.address_space_vnet
    location            = var.location
    resource_group_name = var.rg.name
    tags = var.tags
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = local.ngs
  location            = var.location
  resource_group_name = var.rg.name

  # security_rule {
  #   name                       = "SSH"
  #   priority                   = 1001
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "22"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "http"
  #   priority                   = 1002
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "80"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "https"
  #   priority                   = 1003
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "443"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
  
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.nombre_subnet
  resource_group_name  = var.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_space_subnet
}

resource "azurerm_subnet_network_security_group_association" "ngs_subnet" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


output "subnet" {
    value = azurerm_subnet.subnet
}

output "nsg" {
    value = azurerm_network_security_group.nsg
}

output "vnet" {
    value = azurerm_virtual_network.vnet
}