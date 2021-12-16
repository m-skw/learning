resource "azurerm_network_security_group" "this" {
  name                = var.NetSGName
  location            = var.VNRGLocation
  resource_group_name = var.VNRGName
}


resource "azurerm_virtual_network" "this" {
  name                = var.VNName
  location            = var.VNRGLocation
  resource_group_name = var.VNRGName
  address_space       = var.address_space

}

resource "azurerm_public_ip" "this" {
  count               = var.enablePublicIP ? 1 : 0
  name                = var.PublicIPName
  resource_group_name = var.VNRGName
  location            = var.VNRGLocation
  allocation_method   = "Static"
}

resource "azurerm_subnet" "this" {
  name                 = "internal"
  resource_group_name  = var.subnetRG
  virtual_network_name = var.SubnetName
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "this" {
  name                = var.NIC_name
  location            = var.NIC_location
  resource_group_name = var.NIC_RG

  dynamic "ip_configuration" {
    for_each = var.enablePublicIP ? [1] : []
    content {
      name                          = var.NIC_IP_Name
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = azurerm_public_ip.this[0].id
      subnet_id                     = azurerm_subnet.this.id
    }
  }

  dynamic "ip_configuration" {
    for_each = var.enablePublicIP ? [] : [1]
    content {
      name                          = var.NIC_IP_Name
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = azurerm_subnet.this.id
    }
  }
}