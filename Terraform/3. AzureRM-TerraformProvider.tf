# Providers can be found here: https://registry.terraform.io/browse/providers

# In our examples we're using AzureRM provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest

# Specifying the provider and version - more info https://developer.hashicorp.com/terraform/language/block/provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.44.0" # Using version 4.44.0 or higher of the AzureRM provider
    }
  }
}

provider "azurerm" {
  features {} # Required block for the AzureRM provider
}