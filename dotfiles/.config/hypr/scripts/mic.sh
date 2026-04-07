#!/bin/bash


pamixer --default-source -t
STATUS=$(pamixer --default-source --get-mute)

if [ "$STATUS" = "true" ]; then
    notify-send -a "mic" \
                    -u low \
                    -h string:x-canonical-private-synchronous:mic \
                    -t 2000 \
                    ""
else
    notify-send -a "mic" \
                        -u low \
                        -h string:x-canonical-private-synchronous:mic \
                        -t 2000 \
                        ""
fi