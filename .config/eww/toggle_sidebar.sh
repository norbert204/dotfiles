#!/usr/bin/env bash

COMMAND=$(eww windows)

if [[ ${COMMAND} == *"*dropdown"* ]] ; then
    eww close dropdown
else
    eww open dropdown
fi
