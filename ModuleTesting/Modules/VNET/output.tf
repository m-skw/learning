output "VN_id" {
    description = "Virtual Network ID"
    value       = azurerm_virtual_network.this.id
}

output "VN_Interface_ID" {
    description = "VN interface ID"
    value       = azurerm_network_interface.this.id
}

output "VN_Name" {
    value       = azurerm_virtual_network.this.name
}