## ejecucion sin variable asignada
terraform init
terraform plan
## set variables
$env:TF_VAR_cadena="dato_edsde_env"
$env:TF_VAR_cadena
terraform plan
## usando archivos
terraform plan -var="cadena=desde_var" 
terraform plan -var-file "variablestring.tfvars"
terraform plan -var-file "variablestring.tfvars" -var="cadena=desde_var"

## usando terraform.tfvars
terraform plan
terraform plan -var="cadena=desde_var" 
terraform plan -var-file "variablestring.tfvars"