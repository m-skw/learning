#resource group variables
variable "RGName" {
  type        = string
  default     = "DatabricksTest"
  description = "Resource Group Name"
}

variable "RGLocation" {
  type        = string
  default     = "West Europe"
  description = "Resource Group Location"
}

#VN variables

variable NSGName {
  type        = string
  default     = "DatabricksSGtesting"
  description = "description"
}


variable VNName {
  type        = string
  default     = "VirtualNetworkTesting"
  description = "Virtual Network Name"
}

variable PublicIPName {
  type        = string
  description = "Public IP Name"
  default     = "NATGwPublicIP"
}


variable address_space {
  type        = list(string)
  description = "VN address space"
  default     = ["10.0.0.0/16"]

}

variable subnet {
  type = map
  default = {
    "PublicSubnet"     = "10.0.1.0/24"
    "PrivateSubnet"    = "10.0.2.0/24"
    "BastionVMSubnet"  = "10.0.3.0/24"
  }
}

#Databricks variables

variable Name_DB {
  default = "Databrick_Test"
}