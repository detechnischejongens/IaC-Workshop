# variables allready defined in 6. AzureRM-VirtualMachine.tf

locals {
  vm_count = 3
  vm_sku = "Standard_D2s_v5"
}

# Documentation - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_network_interface" "dtj-winvmcount-nic" {
  count              = local.vm_count
  name                = "${var.vmname}${count.index + 1}-nic" #interpolation with count
  location            = azurerm_resource_group.dtj-resource-group.location
  resource_group_name = azurerm_resource_group.dtj-resource-group.name

  ip_configuration {
    name                          = "internal-${var.vmname}${count.index + 1}-ip"
    subnet_id                     = azurerm_subnet.dtj-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dtj-winvmcount" {
  count               = local.vm_count
  name                = "${var.vmname}${count.index + 1}" #reference to variable with count
  resource_group_name = azurerm_resource_group.dtj-resource-group.name
  location            = azurerm_resource_group.dtj-resource-group.location
  size                = "Standard_D2ds_v5"
  admin_username      = var.VMadmin
  admin_password      = var.VMpassword
  network_interface_ids = [
    azurerm_network_interface.dtj-winvmcount-nic[count.index].id, #count
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "win11-24h2-avd"
    version   = "latest"
  }
}
