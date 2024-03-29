#!/usr/bin/env bash

# This script is designed to automate the setup of EBS volumes on an EC2 instance.
# It creates RAID arrays, formats them, and mounts them on the specified directory.

# Function to format and mount data
format_mount_data() {
    pvcreate /dev/md0 -y
    vgcreate datavg /dev/md0
    lvcreate -l 100%FREE -n datalv datavg
    mkfs -t ext4 /dev/datavg/datalv
    echo "/dev/datavg/datalv ${MOUNT_DIR} ext4  defaults,discard,noatime  0    0" >> /etc/fstab
}

# Backup original /etc/fstab
cp /etc/fstab /etc/fstab.orig

# Create the mount directory
mkdir -p "${MOUNT_DIR}"
echo "Created directory ${MOUNT_DIR}"

# Check and create RAID arrays based on available block devices
if [ -b /dev/xvda ] && [ -b /dev/xvdf ] && [ -b /dev/xvdg ]; then
    mdadm --create /dev/md0  --level=0 --raid-devices=2 /dev/xvdf /dev/xvdg
    format_mount_data
elif [ -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ] && [ -b /dev/nvme2n1 ] && [ -b /dev/nvme3n1 ]; then
    mdadm --create /dev/md0  --level=0 --raid-devices=4 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
    format_mount_data
elif [ -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ] && [ -b /dev/nvme2n1 ]; then
    mdadm --create /dev/md0  --level=0 --raid-devices=2 /dev/nvme0n1 /dev/nvme1n1
    format_mount_data
elif [ -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ]; then
    mkfs -t ext4 /dev/nvme0n1
    echo "EBS volume /dev/nvme0n1 is attached to EC2 instance"
    echo "/dev/nvme0n1 ${MOUNT_DIR} ext4  defaults,discard,noatime   0    0" >> /etc/fstab
elif [ ! -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ] && [ -b /dev/nvme2n1 ] && [ -b /dev/nvme3n1 ] && [ -b /dev/nvme4n1 ]; then
    mdadm --create /dev/md0  --level=0 --raid-devices=4 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1
    format_mount_data
elif [ ! -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ] && [ -b /dev/nvme2n1 ]; then
    mdadm --create /dev/md0  --level=0 --raid-devices=2 /dev/nvme1n1 /dev/nvme2n1
    format_mount_data
elif [ ! -b /dev/xvda ] && [ -b /dev/nvme0n1 ] && [ -b /dev/nvme1n1 ]; then
    mkfs -t ext4 /dev/nvme1n1
    echo "Mounting /dev/nvme1n1 on to ${MOUNT_DIR}"
    mount /dev/nvme1n1 "${MOUNT_DIR}"
    echo "EBS volume /dev/nvme1n1 is attached to EC2 instance"
    echo "/dev/nvme1n1 ${MOUNT_DIR} ext4  defaults,discard,noatime   0    0" >> /etc/fstab
fi

# Mount all filesystems
mount --all
