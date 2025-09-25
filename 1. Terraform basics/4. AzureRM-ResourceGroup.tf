# Documentation with examples: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "dtj-resource-group" {
  name     = "rg-we-dtj-IAC-Workshop" # Name of the resource group
  location = "West Europe"             #Azure region where the resource group will be created
  #location = "North Europe"                  # Azure region where the resource group will be created
}

