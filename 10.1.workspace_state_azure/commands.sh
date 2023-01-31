## ejecucion de comandos 
## el estado queda almacenado en azure
terraform fmt
terraform init -backend-config "./backend.tfbackend"
terraform plan
terraform apply -auto-approve
terraform workspace list
$workspace="dev"
#$workspace="prod"
terraform workspace new $workspace | terraform workspace select $workspace
terraform workspace list
terraform init -backend-config "./backend.tfbackend"
terraform plan --var-file "./$($workspace).tfvars" --out "$($workspace).tfplan"
terraform apply "$($workspace).tfplan"
terraform plan -destroy --var-file "./$($workspace).tfvars" --out "$($workspace).tfplan"
terraform apply "$($workspace).tfplan"

### usando backend fijo
terraform workspace list
$workspace="default"
terraform workspace select default
terraform init -backend-config "./backend.tfbackend"
terraform plan -destroy --out "$($workspace).tfplan"
terraform apply "$($workspace).tfplan"