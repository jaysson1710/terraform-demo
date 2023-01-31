terraform {
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
provider "azurerm" {
  features {
  }
}

provider "random" {
  alias = "random"
}

### azure  ################################
data "azurerm_resource_group" "rg" {
  name = "build-rg"
}

variable "prefix" {
  default = "tfvmex"
}

# resource "azurerm_virtual_network" "main" {
#   name                = "${var.prefix}-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = data.azurerm_resource_group.rg.location
#   resource_group_name = data.azurerm_resource_group.rg.name
# }

output "rg" {
  value = data.azurerm_resource_group.rg
}



### random ################################
resource "random_string" "resource_code" {
  provider = random.random
  length   = 5
  special  = false
  upper    = false
}

output "random" {
  value = "${random_string.resource_code.result}-tst"
}
