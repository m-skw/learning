locals {
NSGRulesInbound = {/*
  ############# INBOUNDS ################  
  databricks-control-plane-ssh = {
    name                          = "databricks-control-plane-ssh"
    priority                      = "100"
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "22"
    source_address_prefixes       = null
    source_address_prefix         = "AzureDatabricks"
    destination_address_prefix    = "VirtualNetwork"
    destination_address_prefixes  = null
  }

  databricks-control-plane-worker-proxy = {
    name                          = "databricks-control-plane-worker-proxy"
    priority                      = "101"
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "5557"
    source_address_prefixes       = null
    source_address_prefix         = "AzureDatabricks"
    destination_address_prefix    = "VirtualNetwork"
    destination_address_prefixes  = null
  }

  databricks-worker-to-worker-inbound = {
    name                          = "databricks-worker-to-worker-inbound"
    priority                      = "102"
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "*"
    source_port_range             = "*"
    destination_port_range        = "*"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefix    = "VirtualNetwork"
    destination_address_prefixes  = null
 }

  ############# OUTBOUNDS ################ 

  databricks-worker-to-webapp = {
    name                          = "databricks-worker-to-webapp"
    priority                      = "100"
    direction                     = "Outbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "443"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefixes  = null
    destination_address_prefix    = "AzureDatabricks"
 }

   databricks-worker-to-sql = {
    name                          = "databricks-worker-to-sql"
    priority                      = "101"
    direction                     = "Outbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "3306"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefix    = "Sql"
    destination_address_prefixes  = null
 }
  
   databricks-worker-to-storage = {
    name                          = "databricks-worker-to-storage"
    priority                      = "102"
    direction                     = "Outbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "443"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefix    = "Storage"
    destination_address_prefixes  = null
 }

   databricks-worker-to-worker-outbound = {
    name                          = "databricks-worker-to-worker-outbound"
    priority                      = "103"
    direction                     = "Outbound"
    access                        = "Allow"
    protocol                      = "*"
    source_port_range             = "*"
    destination_port_range        = "*"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefix    = "VirtualNetwork"
    destination_address_prefixes  = null
 }

    deny-outbound = {
    name                          = "deny-outbound"
    priority                      = "140"
    direction                     = "Outbound"
    access                        = "Deny"
    protocol                      = "*"
    source_port_range             = "*"
    destination_port_range        = "*"
    source_address_prefix         = "*"
    source_address_prefixes       = null
    destination_address_prefix    = "*"
    destination_address_prefixes  = null
  }
     databricks-worker-to-worker-eventhub = {
    name                          = "databricks-worker-to-worker-eventhub"
    priority                      = "104"
    direction                     = "Outbound"
    access                        = "Allow"
    protocol                      = "tcp"
    source_port_range             = "*"
    destination_port_range        = "9093"
    source_address_prefix         = "VirtualNetwork"
    source_address_prefixes       = null
    destination_address_prefix    = "EventHub"
    destination_address_prefixes  = null
  }
  */
 }
}
