
############ function ########################
resource "azurerm_service_plan" "example" {
  name                = "SP-${var.functionname}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os
  sku_name            = var.sku
  tags                = var.tags
}

resource "azurerm_linux_function_app" "example" {
  name                 = var.functionname
  resource_group_name  = var.resource_group_name
  location             = var.location
  tags                 = var.tags
  storage_account_name = var.storage_account_object.name
  service_plan_id      = azurerm_service_plan.example.id
  app_settings = {
    connectionstring            = "${var.storage_account_object.primary_connection_string}"
    data_base                   = "${var.connection_string_database}"
    storagename                 = "${var.storage_account_object.name}"
    FUNCTIONS_WORKER_RUNTIME    = var.runtime
    FUNCTIONS_EXTENSION_VERSION = "~4"
    AzureWebJobsStorage         = "${var.storage_account_object.primary_connection_string}"
  }
  identity {
    type = "SystemAssigned"
  }

  site_config {
    cors {
      allowed_origins = [
        "https://portal.azure.com",
        "https://flow.microsoft.com"
      ]
    }
  }
}