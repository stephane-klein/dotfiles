#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

ssh-keygen -R "[localhost]:2222"
ssh -o StrictHostKeyChecking=no -p 2222 fedora@localhost "bash -s" << 'EOF'
sudo mkdir -p /mnt/host_share
if ! mountpoint -q /mnt/host_share; then
    sudo mount -t 9p -o trans=virtio,version=9p2000.L host_share /mnt/host_share
fi
EOF
