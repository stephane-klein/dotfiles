#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

guestfish --rw -a fedora-working-layer.qcow2 -i rm-rf /var/lib/cloud

qemu-img convert -p -O qcow2 -c -S 0 fedora-working-layer.qcow2 fedora-workstation-sklein.qcow2
rclone copy -P fedora-workstation-sklein.qcow2 scaleway:fedora-workstation
