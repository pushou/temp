variable "hosts" {
  type = number
  default = 2
}
variable "interface" {
  type = string
  default = "ens01"
}
variable "memory" {
  type = string
  default = "2048"
}
variable "vcpu" {
  type = number
  default = 2
}
variable "distros" {
  type = list
  default = ["ubuntu", "rocky"]
}
variable "ips" {
  type = list
  default = ["192.168.122.11", "192.168.122.22"]
}
variable "urls" {
  type = list
  default = ["https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2","https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"]
}

variable "macs" {
  type = list
  default = ["52:54:00:50:99:c5", "52:54:00:0e:87:be"]
}
