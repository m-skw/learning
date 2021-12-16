variable "keyvault_id" {
    description = "Keyvault ID where secret will be stored"
}

variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}

variable "sql_nsg_name" {
  description = "NSG name for SQL"
}

variable "resource_group_name" {
  description = "Resouce group name where DB will be created"
}

variable "location" {
  description = "Location for resource"
}

variable "sql_server_name" {
  description = "SQL Server name"
}


variable "sql_subnet_id" {
  description = "Subnet id"
}

variable "sql_nic_name" {
  description = "SQL NIC name"
}

variable "sql_ip_config_name" {
  description = "IP config name for SQL NIC"
}

variable "sql_vm_size" {
  description = "SQL VM size"
}
