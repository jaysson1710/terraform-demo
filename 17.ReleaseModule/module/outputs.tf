output "storage" {
  sensitive = true
  value = azurerm_storage_account.storage
}
