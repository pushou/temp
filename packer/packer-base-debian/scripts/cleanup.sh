#!/bin/bash

set -e
set -x

sudo apt-get clean
if [ "$PACKER_BUILDER_TYPE" = "amazon-ebs" ]; then
  exit 0
fi

sudo rm /etc/discover-pkginstall.conf
