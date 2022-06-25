#!/usr/bin/env bash

rofi_command="rofi -theme ~/rofi-nord/.rasi/volume.rasi"

## Get Volume
#VOLUME=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')
MUTE=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $6}' | tr -d '[]%')

active=""
urgent=""

if [[ $MUTE == *"off"* ]]; then
    active="-a 1"
else
    urgent="-u 1"
fi

if [[ $MUTE == *"off"* ]]; then
    active="-a 1"
else
    urgent="-u 1"
fi

if [[ $MUTE == *"on"* ]]; then
    VOLUME="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')%"
else
    VOLUME="Mute"
fi

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_MUTED=""
ICON_SETTINGS=""

options="$ICON_UP\n$ICON_MUTED\n$ICON_DOWN\n$ICON_SETTINGS"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$VOLUME" -dmenu $active $urgent -selected-row 0)"
case $chosen in
    $ICON_UP)
        amixer -Mq set Master,0 5%+ unmute && notify-send -u low -t 1500 "Volume Up $ICON_UP"
        ;;
    $ICON_DOWN)
        amixer -Mq set Master,0 5%- unmute && notify-send -u low -t 1500 "Volume Down $ICON_DOWN"
        ;;
    $ICON_MUTED)
        amixer -q set Master toggle
        ;;
    $ICON_SETTINGS)
        pavucontrol
        ;;
esac

