# Qemu Fedora Workstation playground

I use this playground to develop and test my [chezmoi](https://www.chezmoi.io/) installation scripts
in a controlled and reproducible environment, ensuring deterministic behavior.

For more context, see my note in French: [2025-03-09_1038](https://notes.sklein.xyz/2025-03-09_1038/).

## Getting started

```sh
$ mise install -y
$ ./scripts/up.sh
$ ./scripts/enter-in-vm.sh
```

## Rebuild `fedora-workstation-sklein.qcow2`

Operations to create the `fedora-workstation-sklein.qcow2` image from the Fedora upstream image:</code>

```
$ ./scripts/decrypt_secrets.sh
$ source .envrc
$ rm *.qcow2
$ ./scripts/up.sh --use-fedora-cloud-upstream-image
$ ./scripts/install-vm-workstation.sh
$ ./scripts/upload-fedora-workstation.sh
```
