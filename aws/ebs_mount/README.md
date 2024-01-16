# AWS EC2 Instance EBS Volume Configuration Script

This script automates the setup of Elastic Block Store (EBS) volumes on an EC2 instance, creating RAID arrays, formatting them, and mounting them on a specified directory.

## Prerequisites

- Ensure that the necessary block devices (e.g., /dev/xvdf, /dev/xvdg, /dev/nvme0n1, etc.) are attached to the EC2 instance.

## Usage

1. Copy the script to your EC2 instance.
2. Make the script executable: `chmod +x ebs_setup.sh`
3. Execute the script: `./ebs_setup.sh`

## Configuration

The script checks for the availability of different block devices and creates RAID arrays accordingly. You can customize the script to match your specific block device configuration.

### RAID Configuration

- The script supports RAID 0 configurations with various numbers of devices.
- Modify the script to accommodate your specific block device setup.

### Filesystem Configuration

- The script creates logical volumes and filesystems based on the RAID configuration.
- Adjust the script to suit your filesystem preferences.

## Example

```bash
./ebs_setup.sh
```
