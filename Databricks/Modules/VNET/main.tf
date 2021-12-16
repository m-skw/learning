resource "azurerm_network_security_group" "this" {
  name                = var.NSGName
  location            = var.VNRGLocation
  resource_group_name = var.VNRGName
}

/*resource "azurerm_network_security_rule" "this" {
  for_each                     = local.NSGRulesInbound
  name                         = each.key
  priority                     = each.value.priority
  direction                    = each.value.direction
  access                       = each.value.access
  protocol                     = each.value.protocol
  source_port_range            = each.value.source_port_range
  destination_port_range       = each.value.destination_port_range
  source_address_prefixes      = each.value.source_address_prefixes
  source_address_prefix        = each.value.source_address_prefix
  destination_address_prefixes = each.value.destination_address_prefixes #== null ? each.value.destination_address_prefix : each.value.destination_address_prefixes
  destination_address_prefix   = each.value.destination_address_prefix   #== null ? each.value.destination_address_prefixes : each.value.destination_address_prefix
  resource_group_name          = var.VNRGName
  network_security_group_name  = azurerm_network_security_group.this.name
}*/

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = {
    for k, v in var.subnet : k => key
    if key != "BastionVM"
  }
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_virtual_network" "this" {
  name                = var.VNName
  location            = var.VNRGLocation
  resource_group_name = var.VNRGName
  address_space       = var.address_space
  }

resource "azurerm_subnet" "this" {
  for_each             = var.subnet
  name                 = each.key
  resource_group_name  = var.subnetRGname
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
  
  dynamic "delegation" {
    for_each                 = var.subnet != "BastionVM" ? [1] : []
      content {
          name  = "databricks_delegation"

         service_delegation {
          name    = "Microsoft.Databricks/workspaces"
        }
  }
 }
}

resource "azurerm_public_ip" "this" {
  name                = var.PublicIPName
  resource_group_name = var.VNRGName
  location            = var.VNRGLocation
  allocation_method   = "Static"
  sku                 = "Standard"
}