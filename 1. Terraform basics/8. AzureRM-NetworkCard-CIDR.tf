#Terraform functions: https://developer.hashicorp.com/terraform/language/functions

locals {
  nic_count = 5
}

resource "azurerm_network_interface" "dtj-niccount-nic" {
  count               = local.nic_count
  name                = "cidrhost${count.index + 1}-nic" #interpolation with count
  location            = azurerm_resource_group.dtj-resource-group.location
  resource_group_name = azurerm_resource_group.dtj-resource-group.name

  ip_configuration {
    name                          = "internal-${var.vmname}${count.index + 1}-ip"
    subnet_id                     = azurerm_subnet.dtj-subnet1.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(azurerm_subnet.dtj-subnet1.address_prefixes[0], count.index + 11) #Gives count 0 = .11 - cidrhost(prefix, hostnum)
  }
}