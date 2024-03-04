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
