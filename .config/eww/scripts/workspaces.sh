#!/usr/bin/env bash

spaces() {
    active=$(hyprctl activeworkspace -j | jq '.id')
    hyprctl workspaces -j | jq -Mc "map({id: .id | tostring, windows: .windows, fullscreen: .hasfullscreen, current: (if .id == $active then true else false end)})|sort_by(.id)"
}

spaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces
done
