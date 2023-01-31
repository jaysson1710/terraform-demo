# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroup
  location = var.location
  tags = var.tags
}

module "vnet_local" {
    source = "./vnet"
    rg = azurerm_resource_group.rg
    nombre_vnet = "VN-EAU-ECP-DEV-ejemplo"
    nombre_subnet = "SN-EAU-ECP-DEV-ejemplo"
    address_space_vnet = ["10.0.0.0/16"]
    address_space_subnet = ["10.0.1.0/24"]
    tags = var.tags
    location = var.location
}

## modulo externo

locals {
  subnets = cidrsubnets("10.10.0.0/16", 8, 8)
  subnetname = ["subnet1", "subnet2"]
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.10.0.0/16"]
  subnet_prefixes     = local.subnets
  subnet_names        = local.subnetname

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.rg]
}

output "vnet_local" {
    value = module.vnet_local.subnet
}