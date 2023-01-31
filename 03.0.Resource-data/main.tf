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
    http = {
      source  = "hashicorp/http"
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
  alias = "http"
}
provider "random" {
  alias = "random"
}


### cloud ################################
data "azurerm_resource_group" "rg" {
  name = "build-rg"
}

output "rg" {
    value = data.azurerm_resource_group.rg.id
}


### files ################################
data "template_file" "test"{
  template = file("./arm_storage/template.json")
  vars = {
    nombre="ejemplo"
  }
}

locals {
  file = jsondecode(data.template_file.test.rendered)
  valor = local.file.parameters
}

output "file" {
  value = local.file.parameters
}

resource "azurerm_resource_group" "resources_demo" {
  name = "test-rg"
  location = "eastus"
  tags = {
    "env" = "prd"
  }
}




### http ################################

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}
locals {
  httprta = jsondecode(data.http.example.response_body)
}
output "http" {
  value = local.httprta.current_version
}