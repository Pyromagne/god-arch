#!/bin/bash

case "$1" in
    lock)
        # Uses hyprlock if installed, otherwise swaylock
        pidof hyprlock && exit || hyprlock || swaylock
        ;;
    logout)
        # Graceful exit if hyprshutdown exists, else force exit
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit
        ;;
    restart)
        # Use hyprshutdown to close apps gracefully before rebooting
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown -t 'Restarting...' --post-cmd 'reboot' || reboot
        ;;
    shutdown)
        # Use hyprshutdown to close apps gracefully before poweroff
        command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown now' || shutdown now
        ;;
    *)
        echo "Usage: $0 {lock|logout|restart|shutdown}"
        exit 1
esac