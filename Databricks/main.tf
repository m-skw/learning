module "Resource_Group" {
    source     = "./Modules/Resource_Group"
    RGName     = var.RGName
    RGLocation = var.RGLocation
}

module "VNET" {
    source          = "./Modules/VNET"
    NSGName         = var.NSGName
    VNName          = var.VNName
    PublicIPName    = var.PublicIPName
    VNRGName        = module.Resource_Group.resource_group_name
    VNRGLocation    = module.Resource_Group.resource_group_location
    address_space   = var.address_space
    subnetRGname    = module.Resource_Group.resource_group_name
    subnet          = var.subnet
}

module "NAT" {
    source          = "./Modules/NAT"
    NATname         = "${var.RGName}-NAT"
    NATRGlocation   = module.Resource_Group.resource_group_location
    NATRGname       = module.Resource_Group.resource_group_name
    publicIPid      = module.VNET.publicIP
    publicsubnetID  = module.VNET.publicsubnetID
}

module "Databricks" {
    source          = "./Modules/Databricks"
    Name_DB         = var.Name_DB
    RG_DB           = module.Resource_Group.resource_group_name
    Location_DB     = module.Resource_Group.resource_group_location
    PrivSubnet_DB   = module.VNET.privatesubnetName
    VNID_DB         = module.VNET.VN_id
    PubSubnet_DB    = module.VNET.publicsubnetName
    depends_on      = [module.VNET]
}