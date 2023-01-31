terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
}

provider "azurerm" {
    features {
      
    }
}

variable "prefix" {
  default = "tfvmex"
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

locals {
  data = <<CUSTOM_DATA
#!/bin/bash
sudo echo 'andres' >> /home/testadmin/nombre.txt
CUSTOM_DATA
}

resource "azurerm_virtual_machine" "main" {
  lifecycle {
    ignore_changes = [
      tags ,
    ]
    //create_before_destroy = true
  }
  
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"
  tags = {
    "valor" = "value"
  }
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk4"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
    custom_data = base64encode(local.data)
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
  

  connection {
    type     = "ssh"
    user     = "testadmin"
    password = "Password1234!"
    host     = azurerm_public_ip.publicip.ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'export ENV_test=${var.prefix}' >> ~/.bashrc",
    ]
    when = create
    on_failure = fail
  }

  provisioner "file" {
    source      = "readme.md"
    destination = "readme.md"
  }

  depends_on = [
    azurerm_public_ip.publicip
  ]
}

resource "azurerm_public_ip" "publicip" {
  name                = "myTFPublicIP2"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
}

output "ip_public" {
  value = azurerm_public_ip.publicip.ip_address
}

resource "azurerm_virtual_machine_extension" "linux_vm_extension" {
  depends_on=[azurerm_virtual_machine.main]
  name = "linux-settings1234567890-vm-extension"
  virtual_machine_id   = azurerm_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  settings             = <<SETTINGS
    {
        "commandToExecute": "sudo echo 'extension' >> /home/testadmin/extension.txt "
    }
SETTINGS
  
}