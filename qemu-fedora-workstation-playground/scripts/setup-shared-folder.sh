#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

ssh-keygen -R "[localhost]:2222"
ssh -o StrictHostKeyChecking=no -p 2222 stephane@localhost "bash -s" << 'EOF'
mkdir -p /home/stephane/.local/share/chezmoi
if ! mountpoint -q /home/stephane/.local/share/chezmoi; then
    sudo mount -t 9p -o trans=virtio,version=9p2000.L host_share /home/stephane/.local/share/chezmoi
    sudo chown -R stephane:stephane /home/stephane/.local/share/chezmoi
fi
EOF
