terraform {
required_version = "= 1.6.1"
required_providers {
	libvirt = {
      	  source = "dmacvicar/libvirt"
    	}
  }
}
# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
  }
