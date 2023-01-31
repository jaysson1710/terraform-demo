terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  
}


provider "azurerm" {
  features {

  }
}

locals {
  location = "eastus"
  rg       = "build-rg"
}

module "storage" {
  source  = "app.terraform.io/jaysson1710/storage/azurerm"
  version = "1.0.4"
  # insert required variables here
  nombre_storage = "sastorageseguridad"
  location       = local.location
  rg             = local.rg
}

module "storage-jason" {
  source  = "app.terraform.io/jaysson1710/storage-jason/azurerm"
  version = "2.0.0"
  # insert required variables here
  nombre_storage = "sastorageseguridad2"
  location       = local.location
  rg             = local.rg
}

# implementando modulos sobre git generico
module "remoto_git" {
  #source   = "git::https://#{token}#:celuladevops@dev.azure.com/celuladevops/Celula/_git/terraform-azurerm-storage-jason?ref=v2.0.2"
  source   = "git::https://assss:celuladevops@dev.azure.com/celuladevops/Celula/_git/terraform-azurerm-storage-jason?ref=v2.0.2"
  location = local.location
  rg       = "build-rg"
}

module "aks_template" {
  source   = "git::https://ssss@dev.azure.com/swoas/IaC/_git/terraform-azurerm-aks?ref=v1.0.0"
  location = local.location
  rg       = "build-rg"
}

module "remoto_github" {
  source         = "git::https://github.com/jaysson1710/terraform-azurerm-storage?ref=v1.0.2"
  nombre_storage = "sastorageseguridadhub"
  location       = local.location
  rg             = local.rg
}
