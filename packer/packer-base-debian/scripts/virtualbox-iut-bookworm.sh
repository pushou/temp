#!/bin/bash

set -e
set -x

if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  exit 0
fi

# verrue à enlever mais deb.debian.org résoud en IPV6 surement et plante le build

#sudo bash -c "cat <<_EOF >> /etc/hosts
#deb.debian.org 199.232.170.132
#pkgs.k8s.io 34.107.204.206
#redirect.k8s.io 34.107.204.206
#_EOF
#"

#sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
#sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#sudo bash -c "cat <<_EOF >> /etc/sysctl.conf
#net.ipv6.conf.all.disable_ipv6=1
#net.ipv6.conf.default.disable_ipv6=1
#_EOF
#"

# on prépositionne le source list de l'IUT
sudo tee /etc/apt/sources.list.iut << EOF
deb http://debian.iutbeziers.fr/debian bookworm main contrib non-free
#deb-src http://debian.iutbeziers.fr/debian bookworm main

deb http://security.debian.org/debian-security bookworm-security main contrib non-free
#deb-src http://security.debian.org/debian-security bookworm-security main
#
deb http://debian.iutbeziers.fr/debian bookworm-updates main  contrib non-free
#deb-src http://debian.iutbeziers.fr/debian bookworm-updates main

deb http://debian.iutbeziers.fr/debian bookworm-backports main contrib non-free
#deb-src http://debian.iutbeziers.fr/debian bookworm-backports main non-free
EOF
#
sudo tee /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian bookworm main non-free-firmware non-free
#deb-src http://deb.debian.org/debian bookworm main non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware non-free
#deb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware non-free
#deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware

deb http://deb.debian.org/debian bookworm-backports main contrib non-free-firmware non-free
#deb-src http://deb.debian.org/debian bookworm-backports main contrib non-free
EOF

sudo apt-get update

sudo apt-get -y install bzip2
sudo apt-get -y install linux-headers-$(uname -r)
sudo apt-get -y install dkms
sudo apt-get -y install make
sudo sudo apt-get -y install \
 software-properties-common \
 apt-transport-https \
 ca-certificates \
 gnupg2 \
 software-properties-common \
 curl \
 lsb-release

# Uncomment this if you want to install Guest Additions with support for X
#sudo apt-get -y install xserver-xorg

#sudo apt-get -y install  virtualbox-guest-utils virtualbox-guest-x11

#sudo mount -o loop,ro ~/VBoxGuestAdditions.iso /mnt/
#sudo /mnt/VBoxLinuxAdditions.run || :
#sudo umount /mnt/
#rm -f ~/VBoxGuestAdditions.iso

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


curl -s https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public | sudo apt-key add -
sudo curl -s -o /etc/apt/sources.list.d/draios.list https://s3.amazonaws.com/download.draios.com/stable/deb/draios.list
sudo apt-get update

sudo apt install linux-headers-$(uname -r)
sudo apt-get update && sudo apt-get upgrade -y  && sudo apt-get install -y \
 git  \
 wget \
 curl \
 bzip2 \
 telnet \
 debconf \
 locales \
 apt-utils \
 debconf-utils \
 iproute2 \
 net-tools \
 vim \
 python3-pip \
 jupyter-notebook \
 apt-transport-https \
 ca-certificates \
 software-properties-common \
 docker-ce \
 docker-ce-cli \
 containerd.io \
 bind9utils \
 snmp \
 snmp-mibs-downloader \
 figlet \
 tcpdump \
 qemu-kvm \
 snapd \
 libvirt0\
 libvirt-clients \
 libvirt-daemon-system \
 virt-manager \
 open-vm-tools \
 bridge-utils \
 ipython3 \
 docker-ce \
 docker-ce-cli \
 containerd.io \
 at \
 man \
 netplan.io \
 net-tools \
 sysdig \
 nodejs \
 dnsutils \
 mtr \
 libkrb5-dev \
 python3-pkg-resources \
 python3-setuptools \
 python3-requests \
 python3-requestsexceptions \
 npm \
 bash-completion \
 exa \
 ssh \
 git \
 ldap-utils \
 bat \
 pkg-config \
 libssl-dev \
 cargo \
 libcrypt-dev \
 tshark \
 ripgrep \
 ldap-utils

 #systemd-resolved


 #zfsutils-linux

#sudo DEBIAN_FRONTEND=noninteractive apt -y install tshark
sudo git config --global http.sslverify false
sudo git config --global merge.autostash true
export GIT_SSL_NO_VERIFY=true

sudo sed -i "s/event_activation = 1/event_activation = 0/" /etc/lvm/lvm.conf
sudo mkdir -p -m 755 /etc/apt/keyrings


curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg -o /etc/apt/keyrings/kubernetes-keyring.key  

sudo tee /etc/apt/sources.list.d/kubernetes.list << EOF
deb [signed-by=/etc/apt/keyrings/kubernetes-keyring.key] https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update --allow-releaseinfo-change
sudo apt -y install kubelet kubeadm kubectl

# pour memo avant debian 12
#sudo mkdir -m 755 /etc/apt/keyrings
#sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt-get install -y kubectl

#sudo echo 'source <(kubectl completion bash)' >>~/.bashrc

     

sudo mkdir -p /root/.ssh
sudo chmod 700 /root/.ssh
sudo cat /dev/zero | sudo ssh-keygen -t ed25519 -C "made with ssh-key-now" -q -N ""
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCluScPESl1bpumb6lFN/0KEKhEcI+W0VnttVz2jyh9lbwyMoo6eZA7QbwhXx3Qy85u1tD9G1Q6ayzaJ0KdWTRVgqpNA+hWDZ09913zgQS3vnXPvNIBHqZkapnQE7GbegsbCvwfX6ePNBMem9CE8aOKy/6hJU6/ncn1Sf7NxcElRt4xFk9/D0zEjruwApZaWYAT1/O54hfMn1kdkYrRSrz33inR7NPO/LhcJ1WKe+OmDowaEANO49Yr0y83ZzQOmvhBJSfzVA5w2tQIImmWxOagDVEe1kXlyEYqezYcyF77sEAxJTjY90KYOf6DMwn8ke5A0wLDc70cLNR9/UnDJBGr pouchou@portablejmp" | sudo tee -a /root/.ssh/authorized_keys
sudo chmod 600 /root/.ssh/authorized_keys
sudo systemctl enable serial-getty@ttyS0.service

# sudo snap install lxd  
#sudo snap install --edge podman --devmode
#sudo snap install --classic code
#sudo snap install lxd

wget https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.i686
mv ttyd.i686 ttyd
chmod +x ttyd
sudo mv ttyd /usr/local/bin/ttyd

sudo wget -4 https://pkg.osquery.io/deb/osquery_5.8.2-1.linux_amd64.deb  -O /tmp/osquery_5.8.2-1.linux_amd64.deb && sudo dpkg -i /tmp/osquery_5.8.2-1.linux_amd64.deb


sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/student --gecos "User" student
sudo echo "student:student"|sudo chpasswd
sudo echo "root:root"|sudo chpasswd
sudo usermod -aG docker student
sudo usermod -aG libvirt student
sudo echo "Defaults:student !requiretty" |sudo tee -a /etc/sudoers.d/student
sudo echo "student ALL=(ALL) NOPASSWD: ALL" |sudo tee -a /etc/sudoers.d/student
sudo chmod 440 /etc/sudoers.d/student

sudo echo "Europe/Paris" | sudo tee   /etc/timezone
#sudo dpkg-reconfigure -f noninteractive tzdata
sudo sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen
sudo rm -f /etc/default/locale
sudo echo 'LANG="fr_FR.UTF-8"' | sudo tee -a /etc/default/locale
sudo  dpkg-reconfigure --frontend=noninteractive locales
sudo  update-locale LANG=fr_FR.UTF-8

sudo timedatectl set-timezone "Europe/Paris"
#sudo timedatectl set-ntp true


sudo -i -u student <<'EOF'
    sync
    mkdir -p /home/student/.ssh
    chmod 600 /home/student/.ssh/authorized_keys
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCluScPESl1bpumb6lFN/0KEKhEcI+W0VnttVz2jyh9lbwyMoo6eZA7QbwhXx3Qy85u1tD9G1Q6ayzaJ0KdWTRVgqpNA+hWDZ09913zgQS3vnXPvNIBHqZkapnQE7GbegsbCvwfX6ePNBMem9CE8aOKy/6hJU6/ncn1Sf7NxcElRt4xFk9/D0zEjruwApZaWYAT1/O54hfMn1kdkYrRSrz33inR7NPO/LhcJ1WKe+OmDowaEANO49Yr0y83ZzQOmvhBJSfzVA5w2tQIImmWxOagDVEe1kXlyEYqezYcyF77sEAxJTjY90KYOf6DMwn8ke5A0wLDc70cLNR9/UnDJBGr pouchou@portablejmp" | sudo tee -a /home/student/.ssh/authorized_keys
    echo 'source /usr/share/bash-completion/bash_completion' >>~/.bashrc
    echo 'source <(kubectl completion bash)' >>~/.bashrc
    echo 'alias k=kubectl' >>~/.bashrc
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
    /home/student/.cargo/bin/cargo install --locked navi
    mkdir -p /home/student/.local/share/navi/cheats
    git clone https://github.com/pushou/navi-cheats.git /home/student/.local/share/navi/cheats/pushou__navi-cheat
    echo ''eval "$(navi widget bash)">>~/.bashrc
    /home/student/.cargo/bin/cargo  install nu --locked --all-features 
EOF


sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo echo "[Service]" |sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo echo "ExecStart=" |sudo tee -a  /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo echo "ExecStart=-/sbin/agetty --autologin root --noclear %I \$TERM" |sudo tee -a  /etc/systemd/system/getty@tty1.service.d/autologin.conf


#sudo pip3 install docker-py 
#sudo pip install docker-py
# utile pour docker-compose
#sudo apt-get -y remove python-configparser
#sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose

sudo mkdir /home/bin
sudo git clone https://registry.iutbeziers.fr:11443/pouchou/startup.git /home/bin
sudo chmod +x /home/bin/maj.sh
sudo /home/bin/maj.sh
