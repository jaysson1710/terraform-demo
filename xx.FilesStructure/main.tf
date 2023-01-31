resource "random_integer" "number" {
  provider = random.random
  min = 100
  max = 9999
}

module "az_resource_group" {
  source = "./modules/AzureResourceGroup"
  resource_group_name = format("rg-%s",var.name)
  azure_location = var.location
  tags = var.tags
}
 ## registro de github corporativo - del modulo de ejemplo
module "remoto_github" {
  source= "git::https://github.com/jaysson1710/terraform-azurerm-storage?ref=v1.0.4"
  nombre_storage = "sastoragesample${random_integer.number.result}"
  location       = var.location
  rg             = format("rg-%s",var.name)
  depends_on = [
    module.az_resource_group
  ]
}
