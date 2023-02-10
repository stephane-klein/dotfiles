#!/bin/sh

sudo dnf install sway sway-systemd waybar fuzzel swaybg swayidle swaylock wshowkeys mako brightnessctl \
    inotify-tools \ # ~/.config/waybar/launch-waybar.sh script dependency
    wtype # for https://github.com/marty-oehme/bemoji

