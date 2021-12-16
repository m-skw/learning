######resource group variables######
variable "RGName" {
  type        = string
  default     = "S2SVPN"
  description = "Resource Group Name"
}

variable "RGLocation" {
  type        = string
  default     = "West Europe"
  description = "Resource Group Location"
}

##############################################

######Virtual Network variables######
variable VirtualNetworkName {
  type        = string
  default     = "AzVirtualNetworkVPN"
  description = "Virtual Network Name"
}

variable PublicIPName {
  type        = string
  description = "Public IP Name"
  default     = "AzureGWPublicIP"
}


variable VirtualNetworkAddressSpace {
  type        = list(string)
  description = "VN address space"
  default     = ["10.0.0.0/16"]

}

variable VirtualNetworkSubnets {
  type = map
  default = {
    "GatewaySubnet" = "10.0.255.0/27"
  }
}

variable PublicIPAllocationMethod {
  default = "Static"
}

variable PublicIP_SKU {
  default = "Standard"
}

##############################################

######VNGateway variables######

variable VNGatewayName {
  default = "VPNGateway"
}

variable VNGatewayType {
  default = "Vpn"
}

variable VPNType {
  default = "RouteBased"
}

variable isActiveActive {
    type = bool
    default = false
}

variable EnableBGP {
    type = bool
    default = false
}

variable VNGatewaySKU {
  default = "VpnGw1AZ"
}

variable PrivateIPAddrAllocation {
  default = "Dynamic"
}

##############################################

######Local Network GW variables######

variable LocalNetworkGatewayName {
  default = "OnPremGW"
}

variable LocalNetworkGatewayAddress {
  default = "43.74.23.6"
}

variable LocalNetworkGatewayAddressSpace {
  type    = list(string)
  default = ["10.101.0.0/24"] 
}

##############################################

######Virtual Network Gateway Connection Variables######

variable VirtualNetworkGWConnectionName {
  default = "OnPremConnection"
}

variable VirtualNetworkGWConnectionType {
  default = "IPsec"
}

##############################################