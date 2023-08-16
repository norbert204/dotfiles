#!/usr/bin/env bash

brightnessctl | grep -o '[0-9]\+%' | sed 's/%//'
