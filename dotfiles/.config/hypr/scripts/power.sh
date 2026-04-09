#!/bin/bash

uptime="$(uptime -p | sed -e 's/up //g')"

# Options
lock='󰌾'
logout=''
shutdown='󰐥'
reboot=''

chosen=$(echo -e "$lock\n$logout\n$shutdown\n$reboot" | rofi -dmenu -mesg "Uptime: $uptime" -theme ~/.config/rofi/power.rasi)

case "$chosen" in
    $lock)
        pidof hyprlock && exit || hyprlock || swaylock
        ;;
    $logout)
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
        ;;
    $shutdown)
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown now' || shutdown now
        ;;
    $reboot)
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown -t 'Restarting...' --post-cmd 'reboot' || reboot
        ;;
esac