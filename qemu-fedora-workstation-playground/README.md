# Qemu Fedora Workstation playground

I use this playground to develop and test my [chezmoi](https://www.chezmoi.io/) installation scripts
in a controlled and reproducible environment, ensuring deterministic behavior.

For more context, see my note in French: [2025-03-09_1038](https://notes.sklein.xyz/2025-03-09_1038/).

```sh
$ mise install -y
$ ./scripts/decrypt_secrets.sh
$ ./scripts/up.sh
```

Or use `./scripts/up.h --use-fedora-cloud-upstream-image` if you want to start from a base image.

```
$ ./scripts/enter-in-vm.sh
```
