# define variables
variable "vmname" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "VMadmin" {
  description = "The admin username of the Virtual Machine"
  type        = string
}

variable "VMpassword" {
  description = "The admin password of the Virtual Machine"
  type        = string
  sensitive   = true
}

# Documentation - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

resource "azurerm_network_interface" "dtj-winvm-nic" {
  name                = "${var.vmname}-nic" #interpolation
  location            = azurerm_resource_group.dtj-resource-group.location
  resource_group_name = azurerm_resource_group.dtj-resource-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dtj-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "dtj-winvm" {
  name                = var.vmname #reference to variable
  resource_group_name = azurerm_resource_group.dtj-resource-group.name
  location            = azurerm_resource_group.dtj-resource-group.location
  size                = "Standard_D2ds_v5"
  admin_username      = var.VMadmin
  admin_password      = var.VMpassword
  vtpm_enabled        = true
  secure_boot_enabled = true
  license_type        = "Windows_Client"
  provision_vm_agent  = true

  network_interface_ids = [
    azurerm_network_interface.dtj-winvm-nic.id,
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
