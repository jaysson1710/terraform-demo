
terraform workspace list
terraform workspace new dev
terraform workspace list
terraform plan -var-file .\dev.variables.tfvars   
terraform workspace --help
terraform workspace select default
terraform plan -var-file .\qa.variables.tfvars   
terraform workspace delete dev
terraform workspace list

## aplicar este cambio
<#
    resource "azurerm_storage_account" "example" {
        count = "${local.env == "dev" ? 1 : 2}"
        name                     = "saexamplejason${count.index}"
        resource_group_name      = "LogAnalyticsDefaultResources"
        location                 = "eastus2"
        account_tier             = "Standard"
        account_replication_type = "GRS"
    
        tags = {
        environment = local.env
        }
    }

#>
terraform plan -var-file .\qa.variables.tfvars   




<#
es util para cambiar entre multiples instancias con la misma configuracion
copiar diferentes instancias para validacion y pruebas de los cambios
    -- generar entornos de experimentacion
default puede corresponder a main  trunk branch
permite cambio de comportamiento dependiendo del env
no puede ser usado como variable en las configuraciones del backend

genera un directorio de estado terraform.tfstate.d
que debe ser tratado de la misma manera qq terraform.tfstate
#>

