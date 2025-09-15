resource "azurerm_resource_group" "dtj-resource-group" {
  name     = "rg-we-dtj-IAC-Workshop-${terraform.workspace}" # Name of the Resource Group
  location = var.region[terraform.workspace]                 # Azure region where the Resource Group will be created
}