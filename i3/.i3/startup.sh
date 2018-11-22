#!/bin/bash
# System startup script called when i3 starts

# Set monitor placement and size
xrandr --output LVDS1 --auto --left-of HDMI1
xrandr --output HDMI1 --auto
