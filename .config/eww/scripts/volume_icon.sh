#!/usr/bin/env bash

mute=$(pulsemixer --get-mute)
volume=$(pulsemixer --get-volume | sed 's|[0-9]\+\s||g')

headphone=$(grep -A4 -ri 'Headphone Playback Switch' /proc/asound/card2/codec\#0 | grep 'Amp-Out vals:')

if [[ $headphone == *'[0x00 0x00]'* ]]; then
    if [ $mute -eq 1 ]; then
        echo '󰟎';
    else
        echo '󰋋';
    fi
else
    if [ $mute -eq 1 ]; then
        echo '󰝟';
    elif [ $volume -ge 50 ]; then
        echo '';
    elif [ $volume -gt 0 ]; then
        echo '';
    else
        echo '';
    fi
fi
