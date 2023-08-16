#!/usr/bin/env bash

capacity=$(cat "/sys/class/power_supply/BAT1/capacity")
status=$(cat "/sys/class/power_supply/BAT1/status")

if [[ "$status" = "Charging" ]]; then
    echo "󰂄"
    exit
fi

if [[ "$status" = "Full" ]]; then
    echo "󰁹"
    exit
fi

if [[ $capacity -le 10 ]]; then
    echo "󰁺"
elif [[ $capacity -le 20 ]]; then
    echo "󰁻"
elif [[ $capacity -le 30 ]]; then
    echo "󰁼"
elif [[ $capacity -le 40 ]]; then
    echo "󰁽"
elif [[ $capacity -le 50 ]]; then
    echo "󰁾"
elif [[ $capacity -le 60 ]]; then
    echo "󰁿"
elif [[ $capacity -le 70 ]]; then
    echo "󰂀"
elif [[ $capacity -le 80 ]]; then
    echo "󰂁"
elif [[ $capacity -le 90 ]]; then
    echo "󰂂"
else
    echo "󰁹"
fi
