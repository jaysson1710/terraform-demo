# Configure the Azure provider
terraform {
  backend "azurerm" {
  }
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  default = "myTFResourceGroupinVariable"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "brazilsouth"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "brazilsouth"
    resource_group_name = azurerm_resource_group.rg.name
}

