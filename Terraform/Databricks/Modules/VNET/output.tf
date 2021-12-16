output "VN_id" {
    description = "Virtual Network ID"
    value       = azurerm_virtual_network.this.id
}

output "VN_Name" {
    value       = azurerm_virtual_network.this.name
}

output "publicIP" {
    value       = azurerm_public_ip.this.id
}

output "publicsubnetID" {
    value       = azurerm_subnet.this["PublicSubnet"].id
}

output "privatesubnetID" {
    value       = azurerm_subnet.this["PrivateSubnet"].id
}

output "bastionsubnetID" {
    value       = azurerm_subnet.this["BastionVMSubnet"].id
}

output "privatesubnetName" {
    value       = azurerm_subnet.this["PrivateSubnet"].name
}

output "publicsubnetName" {
    value       = azurerm_subnet.this["PublicSubnet"].name
}