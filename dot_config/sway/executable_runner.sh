#!/bin/sh
# This script come from https://old.reddit.com/r/swaywm/comments/pfq8wq/autostart_multiple_instances_on_different/

${@:2} &
swaymsg for_window [pid=$!] move workspace $1;
