# Terraform docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network.html

resource "azurerm_virtual_network" "dtj-vnet" {
    name = "vnet-we-dtj-IAC-Workshop"          # Name of the Virtual Network
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.dtj-resource-group.location
    resource_group_name = azurerm_resource_group.dtj-resource-group.name   
}

resource "azurerm_subnet" "dtj-subnet1" {
  name                 = "snet-subnet1"
  resource_group_name  = azurerm_resource_group.dtj-resource-group.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dtj-subnet2" {
  name                 = "snet-subnet2"
  resource_group_name  = azurerm_resource_group.dtj-resource-group.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}