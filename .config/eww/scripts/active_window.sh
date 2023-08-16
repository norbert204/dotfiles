#!/usr/bin/env bash

socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 awk -F '>>|,' '/^activewindow>>/{print toupper(substr($2, 1, 1)) substr($2, 2)}'
