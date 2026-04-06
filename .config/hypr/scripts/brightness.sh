#!/bin/bash

case "$1" in
  up)
    brightnessctl set 10%+
    ICON="󰃠"
    ;;
  down)
    brightnessctl set 10%-
    ICON="󰃞"
    ;;
esac

BRIGHTNESS=$(brightnessctl info | grep -oP '\(\K[^%]+')

notify-send -a "brightness" \
            -u low \
            -h string:x-canonical-private-synchronous:volume \
            -h int:value:$BRIGHTNESS \
            -t 2000 \
            "$ICON $BRIGHTNESS"