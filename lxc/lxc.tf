variable "proxmoxip" {
	type        = string
	description = "IP of the Proxmox VE Server or Cluster."
}
variable "proxmoxport" {
	type        = string
	description = "Port of the Proxmox VE Server or Cluster."
	default     = 8006
}
variable "proxmoxuser" {
	type        = string
	description = "Proxmox User/Token Name"
	default     = "root@pam!terraform"
}
variable "proxmoxtoken" {
	type        = string
	description = "Proxmox Api Token Secret"
}

terraform {
	required_version = ">= 0.14"
	required_providers {
		proxmox ={
			source = "telmate/proxmox"
		}
	}
}

provider "proxmox" {
	pm_tls_insecure = true
	pm_api_url = "https://${var.proxmoxip}:${var.proxmoxport}/api2/json"
	pm_api_token_id = var.proxmoxuser
	pm_api_token_secret = var.proxmoxtoken
}

resource "proxmox_lxc" "terraform-test" {
  target_node  = "pve"
  hostname     = "terraform-test"
  ostemplate   = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password     = "BasicLXCContainer"
  unprivileged = true
  features {
        nesting = true
    }

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "zfs-DataStor"
    size    = "16G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr2"
    ip     = "dhcp"
    tag    = 10
  }
}
