#!/usr/bin/env bash

pulsemixer --get-volume | sed 's|[0-9]\+\s||g'
