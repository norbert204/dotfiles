#!/bin/bash

#
#	Made by Horváth Norbert
#

MAIN_COLOR="\e[36m"
INVERTED_MAIN_COLOR="\e[37;46m"
E="\e[0m"

echo -e -n "\n$INVERTED_MAIN_COLOR  $E$MAIN_COLOR$E"
echo -e -n "    $MAIN_COLOR$E $(uname -r)"
echo -e -n "    $MAIN_COLOR祥$E $(uptime -p | cut -c4-)"
echo -e -n "    $MAIN_COLOR$E $(awk '/^Mem/ {print $3}' <(free -m))M/$(awk '/^Mem/ {print $2}' <(free -m))M\n"
