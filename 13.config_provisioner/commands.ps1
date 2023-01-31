terraform init
terraform plan --out tf.tfplan

## habilitacion registro logs de ejecucion
## https://developer.hashicorp.com/terraform/internals/debugging
$env:TF_LOG="trace"
$env:TF_LOG_PATH="./logs.txt"

terraform apply tf.tfplan
terraform plan -destroy --out tf.tfplan
terraform apply tf.tfplan

$env:TF_LOG=""
$env:TF_LOG_PATH=""