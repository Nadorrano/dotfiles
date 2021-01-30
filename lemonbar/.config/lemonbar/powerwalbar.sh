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

#1="FontAwesome 5 Free:style=Solid:size=9"
#f1="Material Icons:size=10"
#f2="NotoSansDisplay Nerd Font:size=10"
#f2="NotoSansMono Nerd Font:size=10"
#f2="NotoSerif Nerd Font:size=10"
#f2="RobotoMono Nerd Font:size=11"
#f2="xos4 Terminess Powerline:size=12"
#f2="mplus Nerd Font:size=10"
#f2="OverpassMono Nerd Font:size=10"
#f2="LiterationSerif Nerd Font:size=11"
f1="iMWritingDuospace Nerd Font:size=10"
#f2="Arimo Nerd Font:size=11"
#f2="LiterationSans Nerd Font:size=11"
#f2="Ubuntu Nerd Font:size=11"
#f2="iMWritingMonos Nerd Font:size=10"

SHOW_VOLUME_PERCENTAGE=true
SHOW_BATTERY_PERCENTAGE=true
SHOW_SSID=true

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
        current=${wsname[$((i))]}
        echo -n "%{B$color4}%{F$color0}%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "%{B$color4}%{F$color7}"
        fi
        echo -n "$current%{A}%{B-}%{F-}"
    done
}

get_window(){
	id=$(echo -n "$(xdotool getwindowfocus getwindowname)"  | awk -v len=50 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }')
  echo -n "%{A:rofi -show window:}  $id %{A}"
}

get_song() {
    echo "%{A:mpc toggle:}%{A3:mpd-popup:}  %{A}%{A}"
    echo "%{A:popup-art:}$(mpc current -f %title%) %{A}"
}

network() {
    network_id=$(/sbin/iwgetid -r)
    if [ -n "$network_id" ] ; then
        string=" 直 "
        if [ "$SHOW_SSID" = true ] ; then
            string+="${network_id}"
        fi
    else
        string="   " 
        if [ "$SHOW_SSID" = true ] ; then
            string+="offline "
        fi
    fi
    echo -e "%{A3:urxvt -g 75x25 -e nmtui:}$string%{A}"
}

volume(){
    volume=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer sget Master) | tr -d "[%]")
    mute=$(amixer sget Master | grep "\[off\]")
	  if [[ -n $mute ]]; then
      string=" ﱝ  "
    elif [[ $volume -ge 66 ]] ; then
		  string=" 墳 "
		elif [[ $volume -ge 33 ]] ; then
			string=" 奔 "
		else
			string=" 奄"
		fi
    if [ "$SHOW_VOLUME_PERCENTAGE" = true ] ; then
        string+="$volume%"
    fi
    echo -e "%{A1:amixer sset Master toggle:}%{A4:amixer -q sset Master 3%+ unmute:}%{A5:amixer -q sset Master 3%- unmute:} $string %{A}%{A}%{A}"
}


power_icon(){
    echo -e -n "%{A:sh ~/.config/lemonbar/dmenu_logout.sh &:} 襤 %{A}" # f924 
}

battery() {
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    
    case "$battery_status" in
        Charging)
	          if [ $battery_percent -le "10" ] ; then
	      	  	echo -e -n "   " # f585
	      	  elif [ $battery_percent -le "25" ] ; then
	      	  	echo -e -n "   " # f586
	      	  elif [ $battery_percent -le "50" ] ; then
	      	  	echo -e -n "   " # f587
	      	  elif [ $battery_percent -le "75" ] ; then
	      	  	echo -e -n "   " # f589
	      	  elif [ $battery_percent -le "100" ] ; then
	      	  	echo -e -n "   " # f584
	      	  fi
            if [ "$SHOW_BATTERY_PERCENTAGE" = true ] ; then
                echo "$battery_percent%"
            fi
            ;;
        Discharging)
	          if [ $battery_percent -le "10" ] ; then
	      	  	echo -e -n "  " # f579
	      	  elif [ $battery_percent -le "25" ] ; then
	      	  	echo -e -n "  " # f57b
	      	  elif [ $battery_percent -le "50" ] ; then
	      	  	echo -e -n "  " # f57d
	      	  elif [ $battery_percent -le "75" ] ; then
	      	  	echo -e -n "  " # f57f 
	      	  elif [ $battery_percent -le "100" ] ; then
	      	  	echo -e -n "  " # f578
	      	  fi
            if [ "$SHOW_BATTERY_PERCENTAGE" = true ] ; then
                echo "$battery_percent%"
            fi
            ;;
        Unknown|Full)
            echo -e -n "  "
            if [ "$SHOW_BATTERY_PERCENTAGE" = true ] ; then
                echo "Carica"
            fi
            ;;
    esac
}


calendar() {
    echo -e "   $(date +'%A %d %B %Y') " # f5ed
}

clock() {
    echo -e "   $(date +'%H:%M') " # f64f
}

while true; do
    string=" 
    %{l}%{B$color2}%{F$color7}$(menu)%{RB$color4}$righthard
    $(get_ws)%{F$color4}%{B$color0}$righthard
    %{B$color0}%{F$color7}$(get_window)
    %{r}%{F$color4}$lefthard%{RF$color0}$(network)
    %{F$color2}$lefthard%{RF$color0}$(volume)
    %{F$color4}$lefthard%{RF$color0}$(battery)
    %{F$color2}$lefthard%{RF$color0}$(calendar) 
    %{F$color4}$lefthard%{RF$color0}$(clock)
    %{F$color2}$lefthard%{RF$color0}$(power_icon)%{B-}%{F-}"
    echo -n $string
    sleep 1
done | lemonbar -g x18 -p -f "${f1}" -f "${f2}" -B "$color0" -F "$color4" -a 20  | sh & > /dev/null

