variable VMName {
  type        = string
  description = "Name for Virtual Machine"
}

variable VMLocation {
  type        = string
  description = "Location for VM"
}

variable VMRGName {
  type        = string
  description = "Resource group name for VM"
}

variable vmsize {
  type        = string
  description = "Type of VM"
}

variable publisher {
  type        = string
  description = "Publisher for OS - for Ubuntu it's Canonical"
}

variable offer {
  type        = string
  description = "OS Offer - for ubuntu it's Ubuntu Server"
}

variable sku {
  type        = string
  description = "OS version"
}


variable osdiskname {
  type        = string
  description = "Name for OS disk"
}

variable computer_name {
  type        = string
  description = "hostname for VM"
}

variable admin_username {
    type = string
    description = "username for administrator"
}

variable adminpass {
    type = string
    description = "password for administrator"
}

variable NET_ID {
}