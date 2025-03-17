set -e

cd "$(dirname "$0")/../"

USE_FEDORA_CLOUD_UPSTREAM_IMAGE=0
for arg in "$@"; do
    case $arg in
        --use-fedora-cloud-upstream-image)
            USE_FEDORA_CLOUD_UPSTREAM_IMAGE=1
            shift
            ;;
    esac
done

if [ ! -f "fedora-41-base.qcow2" ]; then
    if [ $USE_FEDORA_CLOUD_UPSTREAM_IMAGE -eq 1 ]; then
        wget -q --progress=bar:force \
            https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2 \
            -O fedora-41-base.qcow2
    else
        wget --progress=bar:force \
            https://fedora-workstation.s3.fr-par.scw.cloud/fedora-workstation-sklein.qcow2 \
            -O fedora-41-base.qcow2

    fi
fi

ACTUAL_SIZE=$(virt-filesystems --long --parts --blkdevs -h -a "fedora-41-base.qcow2" | grep "/dev/sda " | awk '{print $4}')

if [ "$ACTUAL_SIZE" != "10G" ]; then
    qemu-img create -f qcow2 -o preallocation=metadata fedora-41-base-resized.qcow2 10G
    virt-resize --expand /dev/sda4 fedora-41-base.qcow2 fedora-41-base-resized.qcow2
    rm fedora-41-base.qcow2
    mv fedora-41-base-resized.qcow2 fedora-41-base.qcow2
fi

if [ ! -f "fedora-working-layer.qcow2" ]; then
    qemu-img create -f qcow2 -b fedora-41-base.qcow2 -F qcow2 fedora-working-layer.qcow2
fi

cloud-localds cloud-init.img cloud-init.yaml

qemu-system-x86_64 \
    -m 8G \
    -smp 4 \
    -enable-kvm \
    -drive file=fedora-working-layer.qcow2,format=qcow2 \
    -device virtio-vga-gl \
    -display gtk,gl=on \
    -nic user,hostfwd=tcp::2222-:22 \
    -drive file=cloud-init.img,format=raw \
    -fsdev local,id=fsdev0,path=$(pwd)/shared/,security_model=mapped-file \
    -device virtio-9p-pci,fsdev=fsdev0,mount_tag=host_share
