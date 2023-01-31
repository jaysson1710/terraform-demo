
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}
provider "azurerm" {
  features {
    
  }
}

data "azurerm_resource_group" "rg" {
  name = var.rg
}

resource "azurerm_storage_account" "storage" {
  name                     = var.nombre_storage
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = var.tags
}
