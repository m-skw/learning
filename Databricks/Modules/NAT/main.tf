resource "azurerm_nat_gateway" "this" {
  name                = var.NATname
  location            = var.NATRGlocation
  resource_group_name = var.NATRGname
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = var.publicIPid
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  subnet_id      = var.publicsubnetID
  nat_gateway_id = azurerm_nat_gateway.this.id
}