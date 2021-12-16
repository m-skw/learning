variable NetSGName {
  type        = string
  description = "Network Security Group Name"
}

variable VNName {
  type        = string
  description = "Virtual Network Name"
}

variable PublicIPName {
  type        = string
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
  description = "VN address space"
}

variable NIC_name {
  type        = string
  description = "name for NIC"
}

variable NIC_location {
  type        = string
  description = "Location for NIC"
}

variable NIC_RG {
  type        = string
  description = "Resource group for NIC"
}

variable NIC_IP_Name {
  type        = string
  description = "Name for NIC IP"
}


variable subnetRG {
  type        = string
}

variable SubnetName {
  type        = string
}


variable enablePublicIP {
  type        = bool
}