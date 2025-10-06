#!/bin/bash

set -e
set +x
is_centos() {
[[ $(lsb_release -d) =~ "CentOS" ]]
return $?
}
is_rocky() {
[[ $(lsb_release -d) =~ "Rocky" ]]
return $?
}
is_debian() {
[[ $(lsb_release -d) =~ "Debian" ]]
return $?
}
is_ubuntu() {
[[ $(lsb_release -d) =~ "Ubuntu" ]]
return $?
}

#if [ "$PACKER_BUILDER_TYPE" != "amazon-ebs" ]; then
# exit 0
#fi

echo "==> Cleaning up tmp"
sudo rm -rf /tmp/*

# Cleanup apt cache

 
if is_debian || is_ubuntu; then
   sudo apt-get -y autoremove --purge
   sudo apt-get -y clean
   sudo apt-get -y autoclean
fi

if is_centos || is_rocky; then
   sudo dnf clean all --enablerepo=\* 
fi

sudo dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
sudo rm -f /EMPTY
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sudo sync

# bye bye cloud-init
# sudo touch /etc/cloud/cloud-init.disabled

# In CentOS 7, blkid returns duplicate devices
#swap_device_uuid=`sudo /sbin/blkid -t TYPE=swap -o value -s UUID | uniq`
#swap_device_label=`sudo /sbin/blkid -t TYPE=swap -o value -s LABEL | uniq`
#if [ -n "$swap_device_uuid" ]; then
#  swap_device=`readlink -f /dev/disk/by-uuid/"$swap_device_uuid"`
#elif [ -n "$swap_device_label" ]; then
#  swap_device=`readlink -f /dev/disk/by-label/"$swap_device_label"`
#fi
#echo $swap_device
#if [ -z != $swap_device ]
#then
#    sudo /sbin/swapoff "$swap_device"
#    sudo dd if=/dev/zero of="$swap_device" bs=1M || :
#    sudo /sbin/mkswap ${swap_device_label:+-L "$swap_device_label"} ${swap_device_uuid:+-U "$swap_device_uuid"} "$swap_device"
#fi
