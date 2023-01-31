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

locals {
  rg     = format("rg-%s", "ander")
  rguper = upper("VaLo32")
  archivo = file("./template.tpl") ## ejemplo
}

locals {
  subnets = cidrsubnets("10.0.0.0/16", 8, 8)
  tag = tomap({
    name = "a"
    id   = 123
    env = terraform.workspace
  })
  valor   = "12345"
  valores = merge(local.tag, { valor = "${local.valor}" })
}

resource "azurerm_resource_group" "example" {
  name     = local.rg
  location = "West Europe"
  tags     = local.valores
}

resource "azurerm_virtual_network" "example" {
  name                = "vn-network123"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  count                = length(local.subnets)
  name                 = "internal${count.index}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [local.subnets[count.index]]

}


