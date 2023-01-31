## ejecucion de comandos 
## el estado queda almacenado en la nube de terr

## terraform login
## se recibe token que se copia en la consola
## configuracion de variables directamete en cloud
## settings/general se establece si se quiere que se ejecute en la maquina local o en la infra de terra locales o remotos


rm $env:APPDATA\terraform.rc
rm -r .terraform
rm -r .terraform.lock.hcl
terraform init ## falla

## actualizacion de credenciales de Azure
#https://app.terraform.io/app/jaysson1710/workspaces/state-demo/variables
## variables workspace vs variable set

## seleccion del api Token correcto  con los mismos permisos que el usuario q los genera
#https://app.terraform.io/app/jaysson1710/settings/authentication-tokens
## copy file permitions
## windows
cp ./terraform.rc $env:APPDATA
terraform init
terraform plan
terraform apply -auto-approve


## ubuntu
rm ~/.terraformrc
cp terraform.rc ~/.terraformrc
rm -r .terraform
rm -r .terraform.lock.hcl
terraform init
terraform plan
terraform apply -auto-approve


## pipelines
#https://cincycoder.wordpress.com/2019/10/15/terraform-enterprise-config-with-azure-devops/