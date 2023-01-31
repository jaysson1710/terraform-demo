terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

data "template_file" "storage"{
  template = file("./arm_storage/template.json")
  vars = {
    nombre="saejemplojason"
  }
}

resource "azurerm_resource_group" "name" {
  name = var.rg
  location = "eastus"
}

resource "azurerm_resource_group_template_deployment" "storage" {
  name                = "terraform-storage"
  resource_group_name = azurerm_resource_group.name.name
  template_content = data.template_file.storage.rendered
  deployment_mode = "Incremental"
}

resource "azurerm_resource_group_template_deployment" "sql" {
  name                = "terraformsql"
  resource_group_name = var.rg

  template_content = file("template.json")

  parameters_content  = jsonencode({
    "administratorLoginPassword" = { value = var.password},
    "administratorLogin" = { value = var.user},
    "managedInstanceName" = { value = var.nameInstanceSQL}
  })

  deployment_mode = "Incremental"
}

