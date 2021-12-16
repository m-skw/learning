output "VN_id" {
    description = "Virtual Network ID"
    value       = azurerm_virtual_network.this.id
}

/* output "VN_Name" {
    value       = azurerm_virtual_network.this.name
} */

output "publicIP_ID" {
    value       = azurerm_public_ip.this.id
}

output "GatewaySubnetID" {
    value       = azurerm_subnet.this["GatewaySubnet"].id
}