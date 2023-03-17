#!/bin/sh
# This script install Vagrant + Virtualbox + libvirt

# Install Virtualbox
# https://discussion.fedoraproject.org/t/what-is-the-best-way-of-installing-virtualbox-on-f37/74926
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y VirtualBox

# https://developer.hashicorp.com/vagrant/downloads
# Install Vagrant 2.3.4 (this version isn't provided by default Fedora repository)
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install -y libvirt

sudo dnf install -y vagrant
