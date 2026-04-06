#!/bin/bash

DIR="$HOME/Pictures"
FILE="$DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

action="$1"

mkdir -p "$DIR"

notify_screenshot() {
    notify-send -a "screenshot" \
                -i "$FILE" \
                -h string:x-canonical-private-synchronous:screenshot \
                "Screenshot Captured" \
                "Saved to $DIR"
}

case "$action" in
    area)
        grim -g "$(slurp)" "$FILE"
        wl-copy < "$FILE"
        notify_screenshot
        ;;
    full)
        grim "$FILE"
        wl-copy < "$FILE"
        notify_screenshot
        ;;
    *)
        notify-send -a "screenshot" -u critical "Screenshot error" "Unknown action: $action"
        ;;
esac