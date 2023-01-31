terraform init
terraform plan 
terraform apply --auto-approve
terraform state list
terraform state show  azurerm_resource_group.example

###  comando mv
terraform state pull
terraform state mv azurerm_resource_group.example azurerm_resource_group.example1
terraform state show  azurerm_resource_group.example ## falla
terraform state show  azurerm_resource_group.example1

terraform state mv azurerm_resource_group.example1 azurerm_resource_group.example


####### migracion de state ############
# configurar backend
<#
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jaysson1710"
    workspaces {
      name = "local"
    }
    token = ""
  }
#>
##https://app.terraform.io/app/jaysson1710/workspaces/local/states
terraform fmt
terraform init -migrate-state -ignore-remote-version ## problemas de version
terraform plan
terraform state pull


##### comando push
## configuracion backend local -
terraform init -reconfigure
terraform state list
terraform state rm azurerm_resource_group.example1
## configuracion backend remote -
terraform init -reconfigure
## actualizacion de la version en el state
terraform state push -lock=false -force ./terraform.tfstate 
## registrar credenciales en el portal de terraform
terraform plan
terraform destroy --auto-approve
