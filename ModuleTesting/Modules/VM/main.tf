resource "azurerm_virtual_machine" "this" {
  name                          = var.VMName
  location                      = var.VMLocation
  resource_group_name           = var.VMRGName
  vm_size                       = var.vmsize
  network_interface_ids         = var.NET_ID
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
  storage_os_disk {
    name              = var.osdiskname
    create_option     = "FromImage"
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.adminpass
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "LinuxAsm"
  virtual_machine_id   = azurerm_virtual_machine.this.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "script": "${base64encode(file("./script.sh"))}"
    }
SETTINGS
}