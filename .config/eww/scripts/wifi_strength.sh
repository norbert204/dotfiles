#!/usr/bin/env bash

if [[ $(cat /proc/net/wireless | wc -l) -le 2 ]]; then
    echo "0"
else
    echo $(cat /proc/net/wireless | awk 'NR==3 {print substr($3, 1, length($3) - 1)}')
fi
