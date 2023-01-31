# Create public IP
resource "azurerm_public_ip" "publicip" {
  name                = format("PublicIP-%s", var.vmName)
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}


# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = format("NIC-%s", var.vmName)
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = format("NICConfg-%s", var.vmName)
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "vm" {
  lifecycle {
    create_before_destroy = false
  }
  name                  = var.vmName
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vmSize
  tags                  = var.tags
  storage_os_disk {
    name              = format("OsDisk-%s", var.vmName)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
  }

  storage_image_reference {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vmName
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = azurerm_public_ip.publicip.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'export ENV_CONNECTION_DB='${var.connection_db}'' >> ~/.bashrc",
    ]
  }

  depends_on = [
    azurerm_public_ip.publicip
  ]
}

data "azurerm_public_ip" "ip" {
  name                = azurerm_public_ip.publicip.name
  resource_group_name = azurerm_virtual_machine.vm.resource_group_name
  depends_on          = [azurerm_virtual_machine.vm]
}
