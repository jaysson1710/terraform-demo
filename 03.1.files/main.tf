


data "azurerm_resource_group" "rg" {
  name = "build-rg"
}

resource "azurerm_resource_group" "rg2" {
  name     = "build-rg"
  location = "eastus"
}



