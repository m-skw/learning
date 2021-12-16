resource "random_password" "win_admin_password_secret" {
  length = 16
}

resource "azurerm_key_vault_secret" "win_admin_username" {
  name         = "win-sql-admin-username"
  value        = "adminwin"
  key_vault_id = var.keyvault_id
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "win_admin_password" {
  name         = "win-sql-admin-password"
  value        = random_password.win_admin_password_secret.result
  key_vault_id = var.keyvault_id
  tags         = var.tags
}

resource "random_password" "sql_admin_password_secret" {
  length = 16
}

resource "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "sql-admin-username"
  value        = "adminsql"
  key_vault_id = var.keyvault_id
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password" 
  value        = random_password.sql_admin_password_secret.result
  key_vault_id = var.keyvault_id
  tags         = var.tags
}

resource "azurerm_managed_disk" "datadisk" {
  name                 = "${var.sql_server_name}-disk1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 144
}

resource "azurerm_managed_disk" "logdisk" {
  name                 = "${var.sql_server_name}-disk2"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 16
}

resource "azurerm_managed_disk" "backupdisk" {
  name                 = "${var.sql_server_name}-disk3"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = 128
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  managed_disk_id    = azurerm_managed_disk.datadisk.id
  virtual_machine_id = azurerm_virtual_machine.sqlvm.id
  lun                = "1"
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "log" {
  managed_disk_id    = azurerm_managed_disk.logdisk.id
  virtual_machine_id = azurerm_virtual_machine.sqlvm.id
  lun                = "2"
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "backup" {
  managed_disk_id    = azurerm_managed_disk.backupdisk.id
  virtual_machine_id = azurerm_virtual_machine.sqlvm.id
  lun                = "3"
  caching            = "ReadWrite"
}

resource "azurerm_network_security_group" "sqlsecgrp" {
  name                = var.sql_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "RDP"
    priority                   = "1001"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SQLPort"
    priority                   = "1002"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "sqlsubnetnsgassoc" {
  subnet_id                 = var.sql_subnet_id
  network_security_group_id = azurerm_network_security_group.sqlsecgrp.id
}

resource "azurerm_network_interface" "sqlnic" {
  name                = var.sql_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.sql_ip_config_name
    subnet_id                     = var.sql_subnet_id
    private_ip_address_allocation = "dynamic"
  }
}


resource "azurerm_virtual_machine" "sqlvm" {
  name                  = var.sql_server_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.sqlnic.id]
  vm_size               = var.sql_vm_size


  storage_image_reference {
    offer     = "sql2017-ws2019"
    publisher = "MicrosoftSQLServer"
    sku       = "enterprise"
    version   = "latest"
  }

  storage_os_disk {
    name              = "sqlnewOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  //Assign the admin uid/pwd and also comupter name
  os_profile {
    computer_name  = var.sql_server_name
    admin_username = azurerm_key_vault_secret.win_admin_username.value
    admin_password = azurerm_key_vault_secret.win_admin_password.value
  }

  //Here defined autoupdate config and also vm agent config
  os_profile_windows_config {
    //enable_automatic_upgrades = true  
    provision_vm_agent = true
  }
}

resource "azurerm_virtual_machine_extension" "software" {
  name                 = "install-software"
  virtual_machine_id   = azurerm_virtual_machine.sqlvm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  depends_on           = [azurerm_virtual_machine_data_disk_attachment.log, azurerm_virtual_machine_data_disk_attachment.data, azurerm_virtual_machine_data_disk_attachment.backup]

  protected_settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.tf.rendered)}')) | Out-File -filepath install.ps1\" && powershell -ExecutionPolicy Unrestricted -windowstyle hidden -File install.ps1"
  }
  SETTINGS
}

data "template_file" "tf" {
    template = "${file("install.ps1")}"
} 

resource "azurerm_virtual_machine_extension" "sqlextension" {
  name                 = "SqlIaasExtension"
  virtual_machine_id   = azurerm_virtual_machine.sqlvm.id
  publisher            = "Microsoft.SqlServer.Management"
  type                 = "SqlIaaSAgent"
  type_handler_version = "1.2"
  depends_on           = [azurerm_virtual_machine_extension.software] 

  settings           = <<SETTINGS
  {
    
    "AutoTelemetrySettings": {
      "Region": "${var.location}"
    },
    "AutoPatchingSettings": {
      "PatchCategory": "WindowsMandatoryUpdates",
      "Enable": true,
      "DayOfWeek": "Sunday",
      "MaintenanceWindowStartingHour": "2",
      "MaintenanceWindowDuration": "60"
    },
    "KeyVaultCredentialSettings": {
      "Enable": false,
      "CredentialName": ""
    },
    "ServerConfigurationsManagementSettings": {
      "SQLConnectivityUpdateSettings": {
        "ConnectivityType": "Public",
        "Port": "1433"
      },
      "AdditionalFeaturesServerConfigurations": {
        "IsRServicesEnabled": "true"
      }
    }
  }
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
    {
       "SQLAuthUpdateUserName": "${azurerm_key_vault_secret.sql_admin_username.value}",
       "SQLAuthUpdatePassword": "${azurerm_key_vault_secret.sql_admin_password.value}"
    }
PROTECTED_SETTINGS
  tags               = var.tags

}

resource "azurerm_key_vault_secret" "sql_ip_address" {
  name         = "sql-ip-address"
  value        = azurerm_network_interface.sqlnic.private_ip_address
  key_vault_id = var.keyvault_id
  tags         = var.tags
}