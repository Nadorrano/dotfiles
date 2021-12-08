#!/bin/bash

#  _                                _
# | |                              | |
# | |     ___ _ __ ___   ___  _ __ | |__   __ _ _ __
# | |    / _ \ '_ ` _ \ / _ \| '_ \| '_ \ / _` | '__|
# | |___|  __/ | | | | | (_) | | | | |_) | (_| | |
# |______\___|_| |_| |_|\___/|_| |_|_.__/ \__,_|_|
#
# Widgets
#

SHOW_VOLUME_PERCENTAGE=true
SHOW_BATTERY_PERCENTAGE=true
SHOW_SSID=true

menu() {
    echo "%{A:rofi -me-accept-entry "MousePrimary" -me-select-entry '' -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/style_5.rasi:}   %{A}"
}

get_ws() {
    desk=$(xdotool get_desktop)
    wsname=(" 1 " " 2 " " 3 " " 4 " "  " "  " "  ")
    for i in "${!wsname[@]}"; do 
        echo -n "%{B$color4}%{F$color0}%{A:xdotool set_desktop $i:}"
        if [[ "$((desk))" == "$i" ]]; then
            echo -n "%{B$color4}%{F$color7}"
        fi
        current=${wsname[$i]}
        echo -n "${wsname[$i]}%{A}%{B-}%{F-}"
    done
}


get_window() {
	id=$(echo -n "$(xdotool getwindowfocus getwindowname)"  | awk -v len=50 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }')
  echo -n "%{A:rofi -show window:}  $id %{A}"
}


get_song() {
    echo "%{A:mpc toggle:}%{A3:mpd-popup:}  %{A}%{A}"
    echo "%{A:popup-art:}$(mpc current -f %title%) %{A}"
}


network() {
#  interface_up=$(ip link show | awk '/state UP/ {print substr($2, 1, length($2)-1)}')
#  if ! iwconfig $interface_up >/dev/null 2>&1; then
#    echo %{F$COLOR_FOCUSED_DESKTOP_FG}" "
#  else
#    signalStrength=$(awk 'NR==3 {print $3}' /proc/net/wireless)
#  	case $signalStrength in
#  	  [6-9]*) echo %{F$COLOR_FOCUSED_DESKTOP_FG}"▁▃▅▇"
#  		  ;;
#  	  [4-5]*) echo %{F$COLOR_FOCUSED_DESKTOP_FG}"▁▃▅"$DARKGREY"▇"%{F$COLOR_FOCUSED_DESKTOP_FG}
#  		  ;;
#  	  [1-3]*) echo %{F$COLOR_FOCUSED_DESKTOP_FG}"▁▃"$DARKGREY"▅▇"%{F$COLOR_FOCUSED_DESKTOP_FG}
#  		  ;;
#  	  *) echo $DARKGREY" "%{F$COLOR_FOCUSED_DESKTOP_FG}
#  		  ;;
#  	esac 
#  fi



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
  echo -e "%{A3:st -g 75x25 -e nmtui:}$string%{A}"
}

volume() {
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


power_icon() {
    echo -e -n "%{A:dmenu_logout &:} 襤 %{A}" # f924 
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
    echo -e "   $(date +'%H:%M') "       # f64f
}

