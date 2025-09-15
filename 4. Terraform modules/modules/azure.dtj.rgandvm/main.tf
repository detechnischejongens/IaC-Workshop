resource "azurerm_resource_group" "dtj-resource-group" {
  name     = "rg-we-dtj-IAC-Modules" # Name of the resource group
  location = var.azure_region           # Azure region where the resource group will be created
}

resource "azurerm_virtual_network" "dtj-vnet" {
  name                = "vnet-we-dtj-IAC-Modules" # Name of the Virtual Network
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.dtj-resource-group.location
  resource_group_name = azurerm_resource_group.dtj-resource-group.name
}

resource "azurerm_subnet" "dtj-subnet1" {
  name                 = "snet-subnet1-modules"
  resource_group_name  = azurerm_resource_group.dtj-resource-group.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "dtj-subnet2" {
  name                 = "snet-subnet2-modules"
  resource_group_name  = azurerm_resource_group.dtj-resource-group.name
  virtual_network_name = azurerm_virtual_network.dtj-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

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