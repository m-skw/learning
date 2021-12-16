module "Resource_Group" {
    source     = "./Modules/Resource_Group"
    RGName     = var.RGName
    RGLocation = var.RGLocation
}

module "VNET" {
    source          = "./Modules/VNET"
    NetSGName       = var.NetSGName
    VNName          = var.VNName
    PublicIPName    = var.PublicIPName
    VNRGName        = module.Resource_Group.resource_group_name
    VNRGLocation    = module.Resource_Group.resource_group_location
    address_space   = var.address_space
    NIC_name        = "${var.VNName}-NIC"
    NIC_location    = module.Resource_Group.resource_group_location
    NIC_RG          = module.Resource_Group.resource_group_name
    NIC_IP_Name     = "${var.VNName}-NIC-IP"
    subnetRG        = module.Resource_Group.resource_group_name
    SubnetName      = module.VNET.VN_Name
    enablePublicIP  = var.enablePublicIP
}

module "VMCreate" {
    source                = "./Modules/VM"
    VMName                = var.VMName
    VMLocation            = module.Resource_Group.resource_group_location
    VMRGName              = module.Resource_Group.resource_group_name
    NET_ID                = module.VNET.VN_Interface_ID != "" ? [module.VNET.VN_Interface_ID] : [module.VNET.VN_Interface_ID1]
    vmsize                = var.vmsize
    publisher             = var.publisher
    offer                 = var.offer
    sku                   = var.sku
    osdiskname            = "${var.VNName}-vhd"
    computer_name         = "${var.VNName}-VM"
    admin_username        = var.admin_username
    adminpass             = var.adminpass
}