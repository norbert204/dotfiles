#!/usr/bin/env bash

# LAUNCHER_CACHE="/tmp/eww_launcher_cache.json"
# 
# if [[ $(eww windows) == *"*launcher"* ]]; then
#     eww close launcher
# else
#     if test -f "$LAUNCHER_CACHE"; then
#         eww update apps-json="$(cat $LAUNCHER_CACHE)"
#     else
#         eww update apps-json="$(python3 ~/.config/eww/scripts/launcher.py)"
#     fi
# 
#     eww open launcher
# fi

rofi -show drun
