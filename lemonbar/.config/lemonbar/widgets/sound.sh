#!/bin/bash


volume() {
  while :; do
    volume=$(awk -F"[][]" '/Mono:/ { print $2 }' <(amixer sget Master) |
             tr -d "[%]")
    mute=$(amixer sget Master | grep "\[off\]")
	  if [[ -n "$mute" ]]; then
      icon=" 󰝟  "   # f075f
    elif [[ "$volume" -ge 66 ]] ; then
		  icon=" 󰕾  "   # f057e
		elif [[ "$volume" -ge 33 ]] ; then
			icon=" 󰖀  "   # fa7f
		else
			icon=" 󰕿 "   # fa7e
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

