#!/usr/bin/env bash
# This script come from https://old.reddit.com/r/swaywm/comments/10z5zro/how_can_i_autostart_some_flatpak_run_application/

window-events() {
    swaymsg --type subscribe '["window"]' --monitor &
}

wait-for-window() {
    jq --arg app_id "$1" -n 'inputs
    | if (.change == "new") and ((.container.app_id == $app_id) or (.container.window_properties.instance == $app_id))
        then (.container.id, halt)
        else empty
    end'
}

(
    con_id=$(window-events | wait-for-window "$2")
    swaymsg "[con_id=$con_id] move to workspace $1"
    con_id=$(window-events | wait-for-window "$2")
    swaymsg "[con_id=$con_id] move to workspace $1"
) &

${@:3} &
