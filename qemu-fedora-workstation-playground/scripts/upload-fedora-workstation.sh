#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

virt-sysprep --operations cloud-init -d fedora-working-layer.qcow2
qemu-img convert -p -O qcow2 -c -S 0 fedora-working-layer.qcow2 fedora-workstation-sklein.qcow2
rclone copy -P fedora-workstation-sklein.qcow2 scaleway:fedora-workstation
