resource "azurerm_resource_group" "dtj-resource-group-two" {
  name     = "rg-we-dtj-IAC-Workshop2" # Name of the resource group
  location = "West Europe"            # Azure region where the resource group will be created
  
  depends_on = [azurerm_resource_group.dtj-resource-group] # Ensure this resource group is created after the first one
}