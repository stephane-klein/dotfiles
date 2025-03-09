#!/usr/bin/env bash
set -e

sudo localectl set-keymap fr-bepo # I use a bepo keyboard
sudo dnf update -y -q
sudo dnf install -y -q @gnome-desktop @workstation-product gnome-session-wayland-session
sudo systemctl set-default graphical.target
sudo reboot
