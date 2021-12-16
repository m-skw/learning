resource "azurerm_virtual_network" "this" {
  name                = var.VirtualNetworkName
  location            = var.VirtualNetworkRGLocation
  resource_group_name = var.VirtualNetworkRGName
  address_space       = var.VirtualNetworkAddressSpace
  }

resource "azurerm_subnet" "this" {
  for_each             = var.VirtualNetworkSubnets
  name                 = each.key
  resource_group_name  = var.VirtualNetworkSubnetsRGName
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

resource "azurerm_public_ip" "this" {
  name                = var.PublicIPName
  resource_group_name = var.VirtualNetworkRGName
  location            = var.VirtualNetworkRGLocation
  allocation_method   = var.PublicIPAllocationMethod
  sku                 = var.PublicIP_SKU
}