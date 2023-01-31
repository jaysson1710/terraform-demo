## release module steps

##https://blog.knoldus.com/publish-terraform-module/
##https://app.terraform.io/app/jaysson1710/registry/private/modules
##https://github.com/jaysson1710/terraform-azurerm-storage/releases/tag/v1.0.2
##https://www.terraform.io/language/modules/sources

## publicacion del modulo

## habilitar autenticacion a traves de token general 


## error 401 autorizacion
rm $env:APPDATA\terraform.rc
rm -r .terraform
rm -r .terraform.lock.hcl
terraform init 

## copy file permitions
## windows
cp ./terraform.rc $env:APPDATA
terraform init
## linux
rm ~/.terraformrc
cp terraform.rc ~/.terraformrc


terraform fmt
terraform validate
terraform plan


<# proceso de creacion de publicacion de modulos
 con repositorio
    nombramiento https://github.com/jaysson1710/terraform-azurerm-storage
 con terraform cloud
    https://app.terraform.io/app/jaysson1710/registry/private/modules
    
#>
# terraform no permite este tipo de autensitacion or sp, para interactuar con azure ARM
# solicita usar az login (user)
# o los modelos de autenticacion de dentro de terraform
##az login --service-principal 

## importante
## el valor del source no puede ser una variable o una funcion

#$env:TF_VAR_token=""
