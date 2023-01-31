

############## Resource Group #########################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}

###### network ##########################

resource "azurerm_virtual_network" "net" {
  name                = var.vnet_name
  address_space       = [var.vnet_dir]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "SG-${var.vnet_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
  dynamic "security_rule" {
    for_each = local.rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}


resource "azurerm_subnet" "internal" {
  count                = length(local.subnets)
  name                 = "SN_internal${count.index}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = [local.subnets[count.index]]

}

############# VM ###################################
module "vm" {
  source            = "./vm"
  admin_username    = var.user_vm
  admin_password    = var.pass_vm
  location          = var.location
  rg                = var.resource_group
  tags              = var.tags
  vmName            = "vm-linux1"
  image_reference   = "UbuntuServer|Canonical|18.04-LTS"
  subnet            = azurerm_subnet.internal[0].id
  managed_disk_type = "Standard_LRS"
  connection_db     = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.database.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sql_server.administrator_login};Password=${azurerm_mssql_server.sql_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  depends_on = [
    azurerm_mssql_database.database
  ]
}
################ SQL #################################

resource "azurerm_mssql_server" "sql_server" {
  name                         = "example-sqlserver-jason"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.user_db
  administrator_login_password = var.pass_db
  tags                         = var.tags
}

resource "azurerm_mssql_database" "database" {
  name           = "acctest-db-d"
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
  tags           = var.tags
}

############ function ########################
resource "azurerm_storage_account" "storage" {
  count                    = 2
  name                     = "sastoragedemojason${count.index}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

module "function" {
  source                     = "./function"
  functionname               = var.functionname
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  tags                       = var.tags
  storage_account_object     = azurerm_storage_account.storage[0]
  runtime                    = "dotnet"
  connection_string_database = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.database.name};Persist Security Info=False;User ID=${azurerm_mssql_server.sql_server.administrator_login};Password=${azurerm_mssql_server.sql_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sku                        = "Y1"
  os                         = "Linux"
}

