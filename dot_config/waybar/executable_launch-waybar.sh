#!/bin/bash

# This script come from https://github.com/Alexays/Waybar/issues/961

CONFIG_FILES="$HOME/.config/waybar/config
$HOME/.config/waybar/style.css"

trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
