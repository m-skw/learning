resource "azurerm_resource_group" "this" {
  name     = var.RGName
  location = var.RGLocation
}