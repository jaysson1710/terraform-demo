output "function_coleccion_ips" {
  value = azurerm_linux_function_app.example.outbound_ip_address_list
}