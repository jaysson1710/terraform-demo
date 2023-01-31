terraform {
  backend "azurerm" {
  }
  
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.22.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }

  }
}

provider "azurerm" {
  features {}
}

provider "random" {
  alias = "random"
}
