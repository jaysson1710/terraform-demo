terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.24.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
 features {
   
 }
}
provider "http" {
  # Configuration options
}

data "http" "local_ip" {
  url    = "https://api.ipify.org?format=json"
  method = "GET"
}

locals {
  ip = jsondecode(data.http.local_ip.response_body)
}

output "ip" {
  value = local.ip.ip
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_storage_account" "example" {
  name                     = "jasonstoragedemo"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  ##public_network_access_enabled = false
  tags = {
    environment = "staging"
  }
}

# resource "azurerm_storage_account_network_rules" "example2" {
#   storage_account_id = azurerm_storage_account.example.id
#   default_action             = "Allow"
#   ip_rules = [ local.ip.ip ]
# }
resource "azurerm_storage_account_network_rules" "example2" {
  storage_account_id = azurerm_storage_account.example.id
  default_action             = "Deny"
##  virtual_network_subnet_ids = [azurerm_subnet.example.id]
  ip_rules = [ local.ip.ip ]
}