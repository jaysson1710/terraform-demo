## ejecucion de comandos 
## el estado queda almacenado en azure

terraform init -backend-config "./backend.tfbackend"
terraform plan
terraform apply -auto-approve
