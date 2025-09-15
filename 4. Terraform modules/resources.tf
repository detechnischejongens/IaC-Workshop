module "dtj-rgandvm" {
    source = "./modules/azure.dtj.rgandvm" # Path to the module
    azure_region = "westeurope" # Azure region to deploy resources in
    vmname = "dtj-win11-vm" # Name of the Virtual Machine
    VMadmin = "dtjadmin" # Admin username for the Virtual Machine
    VMpassword = "YourP@ssw0rd!" # Admin password for the Virtual Machine
} 