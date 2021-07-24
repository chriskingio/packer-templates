variable "vcenter_server" {
  type        = string
  description = "The hostname of your VCenter Server"
}

variable "vcenter_username" {
  type        = string
  description = "The username for vcenter"
  sensitive   = true
}

variable "vcenter_password" {
  type        = string
  description = "The password for vcenter"
  sensitive   = true
}

variable "vcenter_cluster" {
  type        = string
  description = "The cluster to locate the VM in"
}

variable "template_folder_path" {
  type        = string
  default     = "templates"
  description = "Path to a folder to locate templates in"
}

variable "vm_datastore" {
  type        = string
  description = "Datastore to place VM in"
}

variable "iso_path" {
  type        = string
  description = "The path to the iso on-disk"
}

variable "iso_datastore" {
  type        = string
  description = "Datastore the iso is on"
}

variable "provisioning_network" {
  type        = string
  description = "Network to boot VM on"
}

variable "override_mac_suffix" {
  type        = string
  default     = ""
  description = "Provide a mac suffix (prefix is 00:50:56) to set one in network. Must be in XX:YY:ZZ format"
  validation {
    condition     = length(var.override_mac_suffix) == 8 && can(regex("([0-9a-fA-F]{2}:){2}[0-9a-fA-F]{2}", var.override_mac_suffix))
    error_message = "Must be in the format of XX:YY:ZZ."
  }
}

variable "ssh_username" {
  type        = string
  default     = "root"
  description = "The username to log into the host with, post reboot"
  sensitive   = true
}

variable "ssh_password" {
  type        = string
  default     = "template"
  description = "The password to log into the host with, post reboot; if you change this variable, change the value in preseed.cfg"
  sensitive   = true
}

variable "disk_size_mb" {
  type        = number
  default     = 10000
  description = "The size of the disk to provision for the VM; defaults to 10GB"
}

variable "thin_provision" {
  type        = bool
  default     = true
  description = "Whether to thin provision the disk; defaults to true"
}