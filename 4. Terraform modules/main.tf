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

  #subscription_id = "your-subscription-id" # Mandatory if you not specified the environment var ARM_SUBSCRIPTION_ID
}