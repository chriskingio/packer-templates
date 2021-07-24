locals {
  full_iso_path = "[${var.iso_datastore}] ${var.iso_path}"
  override_mac  = var.override_mac_suffix != "" ? "00:50:56:${lower(var.override_mac_suffix)}" : null
}

source "vsphere-iso" "centos" {
  # Connection settings
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = true
  # Hardware configuration
  cpu_cores = 2
  RAM       = 2048
  # Location configuration
  vm_name             = "centos-template"
  folder              = var.template_folder_path
  cluster             = var.vcenter_cluster
  datastore           = var.vm_datastore
  convert_to_template = true
  # CDRom configuration
  iso_paths = [
    local.full_iso_path
  ]
  # Create configuration
  guest_os_type = "centos7_64Guest"
  notes         = "Created by packer on ${timestamp()}"
  network_adapters {
    network      = var.provisioning_network
    network_card = "vmxnet3"
    mac_address  = local.override_mac
  }
  # Storage
  storage {
    disk_size             = var.disk_size_mb
    disk_thin_provisioned = var.thin_provision
  }
  # Boot configuration
  ssh_username = var.ssh_username
  ssh_password = var.ssh_password
  boot_wait    = "20s"
  # Boot configuration
  http_directory = "http"
  boot_command = [
    "<up><tab>",
    "text ", # non-graphical install
    "ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
}

build {
  sources = ["source.vsphere-iso.centos"]
}
