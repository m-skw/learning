resource "azurerm_virtual_network_gateway" "this" {
  name                = var.VNGatewayName
  location            = var.VNGatewayLocation
  resource_group_name = var.VNGatewayResourceGroupName

  type     = var.VNGatewayType
  vpn_type = var.VPNType

  active_active = var.isActiveActive
  enable_bgp    = var.EnableBGP
  sku           = var.VNGatewaySKU

  ip_configuration {
    name                          = var.VNGatewayIPConfigName
    public_ip_address_id          = var.VNGatewayPublicIP_ID
    private_ip_address_allocation = var.PrivateIPAddrAllocation
    subnet_id                     = var.VNGatewaySubnet_ID
  }
}

resource "azurerm_local_network_gateway" "this" {
  name                = var.LocalNetworkGatewayName
  resource_group_name = var.LocalNetworkGatewayRG
  location            = var.LocalNetworkGatewayLocation
  gateway_address     = var.LocalNetworkGatewayAddress
  address_space       = var.LocalNetworkGatewayAddressSpace
}

resource "random_string" "GWConnectionSharedKey" {
  length           = 16
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  name                = var.VirtualNetworkGWConnectionName
  location            = var.VirtualNetworkGWConnectionRGLocation
  resource_group_name = var.VirtualNetworkGWConnectionRGName

  type                       = var.VirtualNetworkGWConnectionType
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.this.id

  shared_key = random_string.GWConnectionSharedKey.result
}