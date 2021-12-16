resource "azurerm_resource_group" "this" {
  name     = var.RG_Name
  location = var.RG_Location
}