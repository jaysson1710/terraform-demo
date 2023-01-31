terraform {
  backend "azurerm" {
    
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}
variable "name" {
  default = "nombre1"
}
variable "location" {
  default = "eastus"
}
provider "azurerm" {
  features {}
}
provider "random" {
  alias = "random"
}
resource "azurerm_resource_group" "example" {
  name = var.name
  location=var.location
}
