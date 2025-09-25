packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "2.0.1"
    }
    # windows-update = {
    #   version = "0.16.7"
    #   source = "github.com/rgl/windows-update"
    # }
  }
}

variable "tenant_id" {
  type          = string
  description   = "The Active Directory tenant identifier with which your client_id and subscription_id are associated."
}

variable "subscription_id" {
  type          = string
  description   = "Subscription under which the build will be performed"
}

variable "client_id" {
  type          = string
  description   = "The application ID of the AAD Service Principal"
}

variable "client_secret" {
  type          = string
  description   = "A password/secret registered for the AAD Service Principal."
  sensitive     = true
}

source "azure-arm" "PackerBuilder" {
    async_resourcegroup_delete = "true"

    #ARM Tags to make the builder tracable
    azure_tags = {
        PackerTemplate                    = "DuvDUG Demo"
        BuildNumber                       = "Build-like-crazy"
        BuildStartedBy                    = "The n00b"
        BranchName                        = "Start"
    }

    #ARM Connection Info
    tenant_id                              = var.tenant_id
    subscription_id                        = var.subscription_id
    client_id                              = var.client_id
    client_secret                          = var.client_secret

    #ARM Builder Temp resources information
    build_resource_group_name              = "PackerDemo"

    # #ARM Builder Network connection
    # virtual_network_resource_group_name    = "PackerDemo"
    # virtual_network_name                   = "PackerVNET"
    # virtual_network_subnet_name            = "default"
    # private_virtual_network_with_public_ip = "false"

    # Packer Builder Communication Info
    communicator                           = "winrm"
    winrm_insecure                         = "true"
    winrm_timeout                          = "3m"
    winrm_use_ssl                          = "true"
    winrm_username                         = "localadmin"
    winrm_password                         = "D1tismakkelijkTeOnthouden!!@"

    #ARM Marketplace Image Info
    os_type                                = "Windows"
    vm_size                                = "Standard_D2ds_v5"
    image_publisher                        = "MicrosoftWindowsDesktop"
    image_offer                            = "Windows-11"
    image_sku                              = "win11-24h2-avd"
    secure_boot_enabled                    = true
    vtpm_enabled                           = true

    #ARM SIG of the customer
    shared_image_gallery_destination {
        subscription         = var.subscription_id
        resource_group       = "PackerDemo"
        gallery_name         = "ComputeGallery"
        image_name           = "TrustedLaunchImage"
        image_version        = "2025.01.01"
        replication_regions  = ["westeurope"]
        storage_account_type = "Standard_LRS"
    }
    shared_image_gallery_replica_count = 5
}

build {
    sources = ["source.azure-arm.PackerBuilder"]

    provisioner "powershell" {
        inline = [
            "Write-Host 'Hello, World!'"
        ]
    }

    provisioner "powershell" {
        elevated_password = ""
        elevated_user     = "SYSTEM"
        max_retries       =  "2"
        script            = "C:/GitHub/IaC-Workshop/5. Packer Basics/Install-Chocolatey.ps1"
    }

    provisioner "powershell" {
        inline = [
            "choco install 7zip -y",
        ]
    }

    provisioner "windows-restart" {}

    provisioner "powershell" {
        elevated_password = ""
        elevated_user     = "SYSTEM"
        max_retries       =  "2"
        script            = "C:/GitHub/IaC-Workshop/5. Packer Basics/generalize.ps1"
    }

    # provisioner "ansible" {
    #   playbook_file = "./playbook.yml"
    # }

    # #Copy Shared BIS-F Config to VM
    # provisioner "file" {
    #     destination = "C:/Program Files (x86)/Base Image Script Framework (BIS-F)"
    #     source      = "${var.buildsourcesdir}/Image Factory/Packer-Install/5000-SealingLayer/HVC/BIS-F_SharedConfig/"
    # }

    post-processor "manifest" {}
}
