# Import an resources which is being managed outside of Terraform: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "dtj-existing-rg" {
  name = "rg-data-IAC-Workshop" # Name of the existing resource group
}

output "rg-id" {
  value = data.azurerm_resource_group.dtj-existing-rg.id
}