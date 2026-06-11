#!/bin/bash

MIN=5

get_brightness() {
  brightnessctl -m | cut -d, -f4 | tr -d '%'
}

notify_brightness () {
  BRIGHTNESS=$(get_brightness)

  notify-send -a "brightness" \
              -u low \
              -h string:x-canonical-private-synchronous:brightness \
              -h int:value:"$BRIGHTNESS" \
              -t 2000 \
              "$ICON $BRIGHTNESS%"
}

CUR=$(get_brightness)

case "$1" in
  up)
    brightnessctl set 5%+
    ICON="󰃠"
    ;;
  down)
    [ "$CUR" -le "$MIN" ] && exit 0
    brightnessctl set 5%-
    ICON="󰃞"
    ;;
esac

notify_brightness