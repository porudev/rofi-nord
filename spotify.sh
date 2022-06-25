#!/usr/bin/env bash

rofi_command="rofi -theme ./.rasi/spotify.rasi"

stop=""
next=""
previous=""
play_pause=""

# Variable passed to rofi
options="$previous\n$play_pause\n$next\n$stop"

# Get the current playing song
current=$(playerctl --player=spotify metadata --format "{{ artist }} - {{ title }} - {{ album }}")
# If mpd isn't running it will return an empty string, we don't want to display that
if [[ -z "$current" ]]; then
    current="No song is being played!"
fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "  $current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $previous)
        playerctl --player=spotify previous
        ;;
    $play_pause)
        playerctl --player=spotify play-pause
        ;;
    $next)
        playerctl --player=spotify next
        ;;
    $stop)
        killall spotify
        ;;
esac
