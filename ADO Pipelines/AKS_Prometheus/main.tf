terraform {
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = "= 2.78.0"}
    }
    
  backend "azurerm" {
    resource_group_name  = "skwiera-learning-rg"
    storage_account_name = "skwieralearningtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

module "RG" {
    source     = "./Modules/RG"
    RG_Name     = var.RG_Name
    RG_Location = var.RG_Location
}

module "AKS" {
    source = "./Modules/AKS"
    AKSName = var.AKSName
    AKSLocation = module.RG.RG_Location
    AKSRGName = module.RG.RG_Name
    AKSDNSPrefix = "${var.AKSName}Prefix"
    DefaultNodePoolName = var.DefaultNodePoolName
    NodeCount = var.NodeCount
    VMSize = var.VMSize
    IdentityType = var.IdentityType
}