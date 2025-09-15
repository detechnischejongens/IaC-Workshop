#Terraform docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network.html

resource "azurerm_virtual_network" "dtj-vnet" {
  name                = "vnet-data-example" # Name of the Virtual Network
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.dtj-existing-rg.location
  resource_group_name = data.azurerm_resource_group.dtj-existing-rg.name
}

resource "azurerm_subnet" "dtj-subnet1" {
  name                 = "snet-subnet1-dataexample"
  resource_group_name  = data.azurerm_resource_group.dtj-existing-rg.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dtj-subnet2" {
  name                 = "snet-subnet2-dataexample"
  resource_group_name  = data.azurerm_resource_group.dtj-existing-rg.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}