#az login
terraform init
terraform plan
terraform state list
##terraform apply

## obtener identificador en rg > ovweview > (JSON view)
$idrg=$(az group show --resource-group "LogAnalyticsDefaultResources"  | jq '.id')
echo $idrg.replace('"',"") ## quitar """
terraform import azurerm_resource_group.example  $idrg.replace('"',"")
## obtener identificador en storae > overview > (JSON view)
##az resource list --name "saexamplejason" | jq '.[0] | .id'
##az resource list | jq '.[] | select(.name == \"saexamplejason\") | .id'
$idstorage=az resource list --name "saexamplejason" --query "[].id" --out tsv 
echo $idstorage
terraform import azurerm_storage_account.example $idstorage

$stateStorage=terraform state list | wsl grep storage
terraform state show $stateStorage
terraform plan

## remover estado y actualizar la informacion
$staterg=terraform state list | wsl grep group
terraform state rm $staterg
terraform import azurerm_resource_group.example  $idrg.replace('"',"")

##upload to state remoto
## update provider
# configurar backend
<#
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jaysson1710"
    workspaces {
      name = "import"
    }
    token = ""
  }
#>
terraform fmt
terraform validate
terraform init -reconfigure
terraform state list
terraform state push -lock=true ./terraform.tfstate.backup

terraform state rm $stateStorage
terraform state rm $staterg
