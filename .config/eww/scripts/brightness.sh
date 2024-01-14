#!/usr/bin/env bash

current_brightness=$(cat /sys/class/backlight/*/actual_brightness)
max_brightness=$(cat /sys/class/backlight/*/max_brightness)

echo $(( $current_brightness * 100 / $max_brightness ))
