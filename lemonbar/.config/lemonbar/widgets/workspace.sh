#!/bin/bash


get_ws() {
  while :; do
    current_desktop=$(xdotool get_desktop)
    desks=$(xprop -root _NET_DESKTOP_NAMES | sed -E 's/^.*=|[",]//g')
    desktop_names=($desks)
    string=""
    for i in "${!desktop_names[@]}"; do 
      string+="%{B$color5 F$color0 A:xdotool set_desktop $i:}"
      if [[ "$((current_desktop))" == "$i" ]]; then
        string+="%{B$color5 F$color7}"
      fi
      string+=" ${desktop_names[$i]}%{A B- F-}"
    done
    echo "WSP$string"
    sleep 1
  done
}

