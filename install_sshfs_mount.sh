#!/bin/bash

 # Check if sshfs is installed; if not, install it
if ! command -v sshfs &> /dev/null; then
    echo "sshfs is not installed. Installing..."
    sudo apt update
    sudo apt install -y sshfs
fi

# Verify if sshfs installation was successful
if ! command -v sshfs &> /dev/null; then
    echo "Error: sshfs installation failed. Please install sshfs manually and try again."
    exit 1
fi

# Define mount point directory
MOUNT_POINT="/mnt/aws"

# Create mount point directory if it doesn't exist
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Creating mount point directory: $MOUNT_POINT"
     mkdir -p "$MOUNT_POINT"
fi

# Check if the mount point is already mounted
if mountpoint -q "$MOUNT_POINT"; then
    echo "The mount point $MOUNT_POINT is already mounted."
    exit 0
fi


# Mount home directory of the ubuntu user to the mount point using sshfs
echo "Mounting home directory of ubuntu to $MOUNT_POINT..."
 sshfs -o IdentityFile=~/Downloads/sshkey.pem  -o workaround=rename -o allow_other ubuntu@ec2-3-1xx-1xx-xx.us-east-2.compute.amazonaws.com:/home/ubuntu "$MOUNT_POINT"

# Check if mount was successful
if [ $? -eq 0 ]; then
    echo "Mount successful!"
else
    echo "Mount failed. Please check the SSH connection and try again."
fi
