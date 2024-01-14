#!/usr/bin/env bash

if [[ $(cat /sys/class/net/e*/operstate) = "up" ]]; then
    echo "ethernet"
elif [[ $(cat /sys/class/net/w*/operstate) = "up" ]]; then
    echo "wifi"
else
    echo "none"
fi
