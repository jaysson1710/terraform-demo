


terraform {
  backend "local" {
  #   path = "../terraform.tfstate"
  }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "jaysson1710"
  #   workspaces {
  #     name = "local"
  #   }
  #   token = ""
  # }

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.99.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=2.3.0"
    }

  }
}

variable "name" {
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
