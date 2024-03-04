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
