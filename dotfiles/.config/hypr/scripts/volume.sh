#!/bin/bash

MAX=120

notify_volume() {
    VOL=$(pamixer --get-volume)
    MUTED=$(pamixer --get-mute)

    if [ "$MUTED" = "true" ]; then
        ICON=" "
        TEXT="Muted"
        VALUE=0
    else
        TEXT="$VOL"
        VALUE=$VOL
        if [ "$VOL" -le 50 ]; then ICON=" "; 
        else ICON=" "; fi
    fi

    notify-send -a "volume" \
                -u low \
                -h string:x-canonical-private-synchronous:volume \
                -h int:value:"$VALUE" \
                -t 2000 \
                "$ICON $TEXT"
}

case "$1" in
  up)
    CUR=$(pamixer --get-volume)
    VOL=$((CUR + 2))

    if [ "$VOL" -gt "$MAX" ]; then
        VOL=$MAX
    fi

    pamixer --set-volume "$VOL" --unmute --allow-boost
    notify_volume
    ;;
  down)
    pamixer -d 2 --unmute --allow-boost
    notify_volume
    ;;
  mute)
    pamixer -t
    notify_volume
    ;;
esac