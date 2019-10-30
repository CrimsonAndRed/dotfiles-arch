#!/bin/bash

killall -a polybar

while pgrep -u $UID -s polybar >/dev/null; do sleep 1; done

polybar DVI-D-0 &
polybar HDMI-0 &

echo "Polybar launched"
