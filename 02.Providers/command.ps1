
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

<#
provider "azurerm" {
  features {
  }

  subscription_id = "d387-3dc1-4a04-b494-176559453375"
  client_id       = "2a2fd-5d00-4cad-9e31-2557a1e09829"
  client_secret   = ""
  tenant_id       = "7fbe-e540-4556-b198-7b2e16bff9b0"
}
#>

terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve