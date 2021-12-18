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


menu() {
  while :; do
    icon=" "    # f303
    string="MEN%{A:rofi -me-accept-entry 'MousePrimary' -me-select-entry '' "
    string+="-no-lazy-grab -show drun -modi drun "
    string+="-theme ~/.config/rofi/style_5.rasi:} $icon %{A}"
    echo "$string"
    sleep 1
  done
}


get_ws() {
  while :; do
    desk=$(xdotool get_desktop)
    wsname=("  " "  " "  " "  " "ﱘ ")
    string=""
    for i in "${!wsname[@]}"; do 
      string+="%{B$color4 F$color0 A:xdotool set_desktop $i:}"
      if [[ "$((desk))" == "$i" ]]; then
        string+="%{B$color4 F$color7}"
      fi
      string+="${wsname[$i]}%{A B- F-}"
    done
    echo "WSP$string"
    sleep 1
  done
}


get_window() {
  while :; do
	  window_title=$(echo -n "$(xdotool getwindowfocus getwindowname)"  | 
      awk -v len=56 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }')
    echo "WIN%{A:rofi -show window:}  $window_title %{A}" # f2d0
    sleep 3
  done
}


get_song() {
  while :; do
    string="%{A:mpc toggle: A3:mpd-popup:}  %{A A}"
    string+="%{A:popup-art:}$(mpc current -f %title%) %{A}"
    echo "$string"
    sleep 10
  done
}


network() {
  while :; do
    interface_up=$(ip link show | 
                   awk '/state UP/ {print substr($2, 1, length($2)-1)}')
    if iwconfig "$interface_up" >/dev/null 2>&1; then # at least one up
      network_id=$(/sbin/iwgetid -r)
      if [ -n "$network_id" ] ; then # wifi up
        icon=" 直 "   # faa8
        label="$network_id"
      else # ethernet up
        icon="   "   # f6ff
        label="Ethernet"
      fi
    else
      icon="   "     # f65a
      label="Offline"
    fi
    if [ "$SHOW_NETWORK_LABEL" = true ] ; then
      string="$icon$label"
    else
      string="$icon"
    fi
    echo "NET%{A3:st -e nmtui:}$string%{A}"
    sleep 30
  done
}


volume() {
  while :; do
    volume=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer sget Master) |
             tr -d "[%]")
    mute=$(amixer sget Master | grep "\[off\]")
	  if [[ -n "$mute" ]]; then
      icon=" ﱝ  "   # fa5d
    elif [[ "$volume" -ge 66 ]] ; then
		  icon=" 墳 "   # fa7d
		elif [[ "$volume" -ge 33 ]] ; then
			icon=" 奔 "   # fa7f
		else
			icon=" 奄 "   # fa7e
		fi
    if [ "$SHOW_VOLUME_LABEL" = true ] ; then
      string="$icon$volume%"
    else
      string="$icon"
    fi
    echo "VOL%{A1:amixer sset Master toggle: A4:amixer -q sset Master 3%+ unmute: A5:amixer -q sset Master 3%- unmute:} $string %{A A A}"
    sleep 1
  done
}


power_icon() {
  while :; do
    echo "POW%{A:dmenu_logout:} 襤 %{A}" # f924 
    sleep 3
  done
}


battery() {
  while :; do
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    
    case "$battery_status" in
      Charging)
	      if [ $battery_percent -le "10" ]    ; then
	    		icon="   " # f585
	    	elif [ $battery_percent -le "25" ]  ; then
	    		icon="   " # f586
	    	elif [ $battery_percent -le "50" ]  ; then
	    		icon="   " # f587
	    	elif [ $battery_percent -le "75" ]  ; then
	    		icon="   " # f589
	    	elif [ $battery_percent -le "100" ] ; then
	    		icon="   " # f584
	    	fi
        if [ "$SHOW_BATTERY_LABEL" = true ] ; then
          label="$battery_percent%%" # double % or lemonbar will complain
        fi
        ;;
      Discharging)
	      if [ $battery_percent -le "10" ]    ; then
	    		icon="  " # f579
	    	elif [ $battery_percent -le "25" ]  ; then
	    		icon="  " # f57b
	    	elif [ $battery_percent -le "50" ]  ; then
	    		icon="  " # f57d
	    	elif [ $battery_percent -le "75" ]  ; then
	    		icon="  " # f57f 
	    	elif [ $battery_percent -le "100" ] ; then
	    		icon="  " # f578
	    	fi
        label="$battery_percent%%" # double % or lemonbar will complain
        ;;
      Unknown|Full)
        icon="  "
        label="Carica"
        ;;
    esac
    if [ "$SHOW_BATTERY_LABEL" = true ]     ; then
      string="$icon$label"
    else
      string="$icon"
    fi
    echo "BAT${string}"
    sleep 30
  done
}


calendar() {
  while :; do
    echo "DAT   $(date +'%A %d %B %Y')"  # f5ed
    sleep 10
  done
}


clock() {
  while :; do
    echo "TIM   $(date +'%H:%M')"        # f64f
    sleep 10
  done
}

