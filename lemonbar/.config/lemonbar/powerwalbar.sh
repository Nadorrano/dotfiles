#!/bin/bash

#  _                                _
# | |                              | |
# | |     ___ _ __ ___   ___  _ __ | |__   __ _ _ __
# | |    / _ \ '_ ` _ \ / _ \| '_ \| '_ \ / _` | '__|
# | |___|  __/ | | | | | (_) | | | | |_) | (_| | |
# |______\___|_| |_| |_|\___/|_| |_|_.__/ \__,_|_|
#
#  github.com/fikriomar16

pkill lemonbar

. "${HOME}/.cache/wal/colors.sh"

bg="%{B$color4}%{F$color0}"
active="%{B$color4}%{F$color7}"

f2="FontAwesome 5 Free:style=Solid:size=9"
f1="xos4 Terminess Powerline"

righthard=""
rightsoft=""
lefthard=""
leftsoft=""


menu(){
    echo "%{A:rofi -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/style_5.rasi:}  Menu %{A}"
}

get_ws(){
    desk=$(xdotool get_desktop)
    wsname=(" 1 " " 2 " " 3 " " 4 ")
    for i in {0..3}; do
        echo -n "$bg%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "$active"
        else
            echo -n ""
        fi
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        else
            echo -n "${wsname[$((i))]}" | tr '[:lower:]' '[:upper:]'
        fi
        echo -n "%{A}%{B-}%{F-}"
    done
}

get_window(){
	id=$(echo -n "$(xdotool getwindowfocus getwindowname)"  | awk -v len=50 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }')
  echo -n "%{A:rofi -show window:} $id %{A}"
}

get_song() {
    echo "%{A:mpc toggle:}%{A3:mpd-popup:}  %{A}%{A}"
    echo "%{A:popup-art:}$(mpc current -f %title%) %{A}"
}

network() {
    show_ssid=true
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ] ; then
        string=" \uf6ff "
        if [ "$show_ssid" = true ] ; then
            string+="${network_id} "
        fi
    else
        string="  "
        if [ "$show_ssid" = true ] ; then
            string+="offline "
        fi
    fi
    echo -e "%{A3:urxvt -g 75x25 -e nmtui:}$string%{A}"
}

volume(){
    show_percentage=true
    volume=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer sget Master) | tr -d "[%]")
    mute=$(amixer sget Master | grep "\[off\]")
    if [ -n "$mute" ]
    then
        string="\uf6a9 "
    else
        string="\uf028 "
    fi
    gray=$((127 - (volume * 127 / 100 )))
    color_var=$(printf '#%02x%02x%02x' $gray $gray $gray)
    if [ "$show_percentage" = true ] ; then
        string+="%{F$color0}$volume% "
    fi
    echo -e "%{F$color_var}%{A1:amixer sset Master toggle:}%{A4:amixer -q sset Master 3%+ unmute:}%{A5:amixer -q sset Master 3%- unmute:} $string %{A}%{A}%{A}%{F-}"
}


power_icon(){
    echo -e -n " %{A:sh ~/.config/lemonbar/dmenu_logout.sh &:} \uf011 %{A}" 
}

battery() {
    show_percentage=true
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    
    case "$battery_status" in
        Charging)
            echo -e -n " \uf1e6 "
            if [ "$show_percentage" = true ] ; then
                echo "$battery_percent%"
            fi
            ;;
        Discharging)
	          if [ $battery_percent -le "10" ] ; then
	      	  	echo -e -n " \uf244 "
	      	  elif [ $battery_percent -le "25" ] ; then
	      	  	echo -e -n " \uf243 "
	      	  elif [ $battery_percent -le "50" ] ; then
	      	  	echo -e -n " \uf242 "
	      	  elif [ $battery_percent -le "75" ] ; then
	      	  	echo -e -n " \uf241 "
	      	  elif [ $battery_percent -le "100" ] ; then
	      	  	echo -e -n " \uf240 "
	      	  fi
            if [ "$show_percentage" = true ] ; then
                echo "$battery_percent%"
            fi
            ;;
        Unknown|Full)
            echo -e -n " \uf1e6 "
            if [ "$show_percentage" = true ] ; then
                echo "Carica"
            fi
            ;;
    esac
}


calendar() {
    echo -e " \uf133 $(date +'%A %d %B %Y') "
}

clock() {
    echo -e " \uf017 $(date +'%H:%M') "
}

while true; do
    string=" 
    %{l}%{B$color2}%{F$color7}$(menu)%{RB$color4}$righthard
    $(get_ws)%{F$color4}%{B$color0}$righthard
    %{B$color0}%{F$color7}$(get_window)
    %{r}%{F$color4}$lefthard%{RF$color0}$(network)
    %{F$color2}$lefthard%{R}$(volume)
    %{F$color4}$lefthard%{RF$color0}$(battery)
    %{F$color2}$lefthard%{RF$color0}$(calendar) 
    %{F$color4}$lefthard%{RF$color0}$(clock)
    %{F$color2}$lefthard%{RF$color0}$(power_icon)%{B-}%{F-}"
    echo -n $string
    sleep 1
done | lemonbar -g x18 -p -f "${f1}" -f "${f2}" -B "$color0" -F "$color4" -a 20  | sh & > /dev/null

