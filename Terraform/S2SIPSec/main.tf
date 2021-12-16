module "Resource_Group" {
    source     = "./Modules/Resource_Group"
    RGName     = var.RGName
    RGLocation = var.RGLocation
}

module "VNET" {
    ###Virtual Network###
    source                     = "./Modules/VNET"
    VirtualNetworkName         = var.VirtualNetworkName
    VirtualNetworkRGName       = module.Resource_Group.resource_group_name
    VirtualNetworkRGLocation   = module.Resource_Group.resource_group_location
    VirtualNetworkAddressSpace = var.VirtualNetworkAddressSpace

    ##Subnets###
    VirtualNetworkSubnetsRGName = module.Resource_Group.resource_group_name
    VirtualNetworkSubnets       = var.VirtualNetworkSubnets

    ###Public IP###
    PublicIPName               = var.PublicIPName
    PublicIPAllocationMethod   = var.PublicIPAllocationMethod
    PublicIP_SKU               = var.PublicIP_SKU
}

module "S2SVPN" {
    ###Virtual Network Gateway###
    source                      = "./Modules/S2SVPN"
    VNGatewayName               = var.VNGatewayName
    VNGatewayLocation           = module.Resource_Group.resource_group_location
    VNGatewayResourceGroupName  = module.Resource_Group.resource_group_name
    VNGatewayType               = var.VNGatewayType
    VPNType                     = var.VPNType
    isActiveActive              = var.isActiveActive
    EnableBGP                   = var.EnableBGP
    VNGatewaySKU                = var.VNGatewaySKU
    VNGatewayIPConfigName       = "${var.VNGatewayName}-IpConfig"
    VNGatewayPublicIP_ID        = module.VNET.publicIP_ID
    PrivateIPAddrAllocation     = var.PrivateIPAddrAllocation
    VNGatewaySubnet_ID          = module.VNET.GatewaySubnetID
    #############################

    ###Local Network Gateway###
    LocalNetworkGatewayName         = var.LocalNetworkGatewayName
    LocalNetworkGatewayRG           = module.Resource_Group.resource_group_name
    LocalNetworkGatewayLocation     = module.Resource_Group.resource_group_location
    LocalNetworkGatewayAddress      = var.LocalNetworkGatewayAddress
    LocalNetworkGatewayAddressSpace = var.LocalNetworkGatewayAddressSpace
    #############################

    ###Virtual Network Connection###
    VirtualNetworkGWConnectionName       = var.VirtualNetworkGWConnectionName
    VirtualNetworkGWConnectionRGLocation = module.Resource_Group.resource_group_location
    VirtualNetworkGWConnectionRGName     = module.Resource_Group.resource_group_name
    VirtualNetworkGWConnectionType       = var.VirtualNetworkGWConnectionType
    #############################
}