terraform {
  required_providers {
    
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }    

    random = {
      source = "hashicorp/random"
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

## loop #################################

resource "azurerm_resource_group" "example" {
  count = 2
  name     = "rg-resources-${count.index}"
  location = "West Europe"
}


resource "azurerm_virtual_network" "example" {
  count = 2
  name                = "vn-network${count.index}"
  address_space       = ["10.0.${count.index}.0/16"]
  location            = "West Europe"
  resource_group_name =  azurerm_resource_group.example[count.index].name
}

## random #################################

resource "random_integer" "name" {
  provider = random.random
  min = 1
  max = 100
}

## for_each #################################

## uso de lista set
resource "azurerm_storage_account" "example" {
  for_each = local.rgs
  name                     = "storage${random_integer.name.result}"
  resource_group_name      = each.value
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
## uso de map map
resource "azurerm_storage_account" "otrofor" {
  for_each = {
    name1="test"
    name2="demo"
  }
  name                     = "storage${each.key}"
  resource_group_name      = each.value
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

## example for
locals {
  rgs = toset([for e in azurerm_resource_group.example : e.name])
  address_vnet = "10.0.0.0/16"
  ## tuple
  address_sub = [for i, v in ["default","privateendpoint","appliback","Cont"] : { "name":v , "address": cidrsubnet(local.address_vnet,8,i)}]
  ## object
  address_sub2 = {for i, v in ["default","privateendpoint","appliback","Cont"] : v => cidrsubnet(local.address_vnet,8,i)}
}

output "direccion" {
    value = local.address_sub2.Cont
}
output "direccion_2" {
    value = local.address_sub[0].address
}

output "direccion_2_2" {
    value = local.address_sub[0]["address"]
}

############# dynamic block
## XX.ejercicio
