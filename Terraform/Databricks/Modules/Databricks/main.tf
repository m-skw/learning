resource "azurerm_databricks_workspace" "this" {
  name                = var.Name_DB
  resource_group_name = var.RG_DB
  location            = var.Location_DB
  sku                 = "standard"
  
  custom_parameters  {
      no_public_ip        = false
      private_subnet_name = var.PrivSubnet_DB
      virtual_network_id  = var.VNID_DB
      public_subnet_name  = var.PubSubnet_DB
  }
}