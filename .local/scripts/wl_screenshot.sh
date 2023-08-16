#!/bin/bash

use_slurp=false;

while getopts s flags
do
    case "${flags}" in
        s) use_slurp=true;;
    esac
done

if $use_slurp; then
    grim -g "$(slurp)"
else
    grim
fi

notify-send "Screenshot taken"
