#!/usr/bin/env bash


rofi_command="rofi -theme ~/rofi-nord/.rasi/apps.rasi"

# Links
terminal=""
files=""
editor=""
browser=""
music=""
settings=""

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
    $terminal)
		kitty
        ;;
    $files)
		thunar
		;;
    $editor)
		code
        ;;
    $browser)
		firefox
        ;;
    $music)
		/home/porudev/rofi/1080p/applets/menu/mpd.sh
        ;;
    $settings)
		system-monitoring-center
        ;;
esac
