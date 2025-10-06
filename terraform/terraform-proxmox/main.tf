variable  "pm_api_url" {
 default =  "https://10.255.255.246:8006/api2/json"
}
variable  "pm_api_token_id" {
    default =  "terraform@pve!terraform"
}
variable  "pm_api_token_secret" {
    default =  "586119c7-e997-4047-8aff-44ea765e6cc7"
}
variable  "target_node" {
    default =  "pve-hp2"
}
variable "clone" {
    default =  "ubuntu-2204-cloudinit-template"
}
variable  "ssh_key" {
    default =  "ssh-rsa aaaab3nzac1yc2eaaaadaqabaaabaqcluscpesl1bpumb6lfn/0kekheci+w0vnttvz2jyh9lbwymoo6eza7qbwhxx3qy85u1td9g1q6ayzaj0kdwtrvgqpna+hwdz09913zgqs3vnxpvnibhqzkapnqe7gbegsbcvwfx6epnbmem9ce8aoky/6hju6/ncn1sf7nxcelrt4xfk9/d0zejruwapzawyat1/o54hfmn1kdkyrrsrz33inr7npo/lhcj1wke+omdowaeano49yr0y83zzqomvhbjsfzva5w2tqiimmwxoagdvee1kxlyeyqezycyf77seaxjtjy90kyof6dmwn8ke5a0wldc70clnr9/undjbgr pouchou@portablejmp"
}


resource "proxmox_vm_qemu" "tp_servers" {
  desc = "Deploiement ubuntu Proxmox"
  count = 3
  name = "test-vm${count.index + 1}"
  target_node = var.target_node
  clone = var.clone

  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "50G"
    type = "scsi"
    storage = "VM"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr1"
  }

  ipconfig0 = "ip=192.168.1.${count.index + 1}/24,gw=192.168.1.1"
  nameserver = "10.255.255.200"
  searchdomain = "iutbeziers.fr"
}
