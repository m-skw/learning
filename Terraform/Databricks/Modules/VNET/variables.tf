variable NSGName {
  type        = string
  description = "Network Security Group Name"
  default     = "DatabricksSGtesting"
}

variable VNName {
  type        = string
  default     = "VirtualNetworkTesting"
  description = "Virtual Network Name"
}

variable PublicIPName {
  type        = string
  default     = "NATGwPublicIP"
  description = "Public IP Name"
}

variable VNRGName {
  type        = string

  description = "Resource group for VN"
}

variable VNRGLocation {
  type        = string
  description = "Resourge group location for VN"
}


variable address_space {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "VN address space"
}

variable subnet {}

/* variable subnet_prefixes {
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable subnetnames {
  type = list(string)
  default = ["PublicSubnet","PrivateSubnet","BastionVM"]
}
 */
variable subnetRGname {
  default = "PlaningRG"
}

