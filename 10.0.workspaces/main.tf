terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  
  # cloud {
  #   organization = "jaysson1710"

  #   workspaces {
  #     name = "state-${terraform.workspace}"
  #   }
  #   token = ""
  # }
}

provider "azurerm" {
  features {
    
  }
}

variable "name" {
  type = string
  description = "(optional) describe your variable"
}

locals {
  env = terraform.workspace
}

resource "azurerm_resource_group" "rg" {
  name = "rg-demo1"
  location = "eastus"
  tags = tomap({
    env = local.env
  })
}

output "rg" {
  value = azurerm_resource_group.rg.name
}


