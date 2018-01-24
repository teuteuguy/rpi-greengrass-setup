#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

adduser --system ggc_user
addgroup --system ggc_group

apt-get update
apt-get install -y sqlite3 git rpi-update

rpi-update b81a11258fc911170b40a0b09bbd63c84bc5ad59

echo fs.protected_hardlinks = 1 >> /etc/sysctl.d/98-rpi.conf
echo fs.protected_symlinks = 1 >> /etc/sysctl.d/98-rpi.conf

curl https://raw.githubusercontent.com/tianon/cgroupfs-mount/951c38ee8d802330454bdede20d85ec1c0f8d312/cgroupfs-mount > /tmp/cgroupfs-mount.sh
chmod +x /tmp/cgroupfs-mount.sh 
/tmp/cgroupfs-mount.sh
