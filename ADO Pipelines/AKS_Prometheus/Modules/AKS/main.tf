resource "azurerm_kubernetes_cluster" "this" {
  name                = var.AKSName
  location            = var.AKSLocation
  resource_group_name = var.AKSRGName
  dns_prefix          = var.AKSDNSPrefix

  default_node_pool {
    name       = var.DefaultNodePoolName
    node_count = var.NodeCount
    vm_size    = var.VMSize
  }

  identity {
    type = var.IdentityType
  }
}