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
        wget -q \
            https://download.fedoraproject.org/pub/fedora/linux/releases/41/Cloud/x86_64/images/Fedora-Cloud-Base-Generic-41-1.4.x86_64.qcow2 \
            -O fedora-41-base.qcow2
    else
        wget -q \
            https://fedora-workstation.s3.fr-par.scw.cloud/fedora-workstation-sklein.qcow2 \
            -O fedora-41-base.qcow2
    fi
fi

cloud-localds cloud-init.img cloud-init.yaml

if [ ! -f "fedora-working-layer.qcow2" ]; then
    qemu-img create -f qcow2 -b fedora-41-base.qcow2 -F qcow2 fedora-working-layer.qcow2
fi
qemu-img resize fedora-working-layer.qcow2 10G

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
