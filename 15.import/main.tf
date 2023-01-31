terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.99.0"
    }
  }
  
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "example" {
  name     = "LogAnalyticsDefaultResources"
  location = "eastus2"
}

resource "azurerm_storage_account" "example" {
  name                     = "saexamplejason"
  resource_group_name      = "LogAnalyticsDefaultResources"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
