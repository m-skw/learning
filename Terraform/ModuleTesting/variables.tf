#resource group variables
variable "RGName" {
  type        = string
  default     = "TestVMTerraform"
  description = "Resource Group Name"
}

variable "RGLocation" {
  type        = string
  default     = "West Europe"
  description = "Resource Group Location"
}

#VN variables

variable NetSGName {
  type        = string
  default     = "UbuntuSecurityGroup123"
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
  default     = "TestingPBIPN12311"
}


variable address_space {
  type        = list(string)
  description = "VN address space"
  default     = ["10.0.0.0/16"]
}

variable enablePublicIP {
  type        = bool
  default     = false
}

#VM Variables

variable VMName {
  type        = string
  default     = "TestingVM421d"
  description = "Name for Virtual Machine"
}

variable vmsize {
  type        = string
  default     = "Standard_B1s"
  description = "Type of VM"
}

variable publisher {
  type        = string
  default     = "Canonical"
  description = "Publisher for OS - for Ubuntu it's Canonical"
}

variable offer {
  type        = string
  default     = "UbuntuServer"
  description = "OS Offer - for ubuntu it's Ubuntu Server"
}

variable sku {
  type        = string
  default     = "18.04-LTS"
  description = "OS version"
}

variable admin_username {
    type        = string
    default     = "mskwierczy001"
    description = "username for administrator"
}

variable adminpass {
    type = string
    default = "Testingpassword123!"
    description = "password for administrator"
}