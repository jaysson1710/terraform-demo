terraform {
  cloud {
    organization = "jaysson1710"
    token = ""
    workspaces {
      name = "state-demo"
    }
  }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "jaysson1710"
  #   workspaces {
      
  #     prefix = "state-"
  #   }
  # }

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }

    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }

  }
}

variable "name" {
  default = "test-rg"
}

provider "azurerm" {
  features {}
}

provider "random" {
  alias = "random"
}

resource "azurerm_resource_group" "example" {
  name     = var.name
  location = "West Europe"
}
