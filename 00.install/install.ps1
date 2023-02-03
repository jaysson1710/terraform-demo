<#
https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-windows-powershell?tabs=bash
#>

#$PSVersionTable.PSVersion
$path = "c:\apps\"
mkdir $path
Start-BitsTransfer -Source "https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_windows_amd64.zip" -Destination "$($path)\terraform.zip"
#curl  https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_windows_amd64.zip -o "$($path)\terraform.zip"
Expand-Archive -LiteralPath "$($path)\terraform.zip" -DestinationPath $path -Force
$env:PATH = $env:PATH + ";" + $path
##$env:PATH + ";" + $path >> $PROFILE

## option modify cat $PROFILE
