#!/bin/bash


battery() {
  while :; do
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    
    case "$battery_status" in
      "Charging")
        if [ $battery_percent -le "10" ]    ; then
          icon=" 󰢜  " # f089c
        elif [ $battery_percent -le "25" ]  ; then
          icon=" 󰂆  " # f0086
        elif [ $battery_percent -le "50" ]  ; then
          icon=" 󰢝  " # f089d
        elif [ $battery_percent -le "75" ]  ; then
          icon=" 󰢞  " # f089e
        elif [ $battery_percent -le "100" ] ; then
          icon=" 󰂅  " # f0085
        fi
        if [ "$SHOW_BATTERY_LABEL" = true ] ; then
          label="$battery_percent%%" # double % or lemonbar will complain
        fi
        ;;
      "Discharging")
        if [ $battery_percent -le "10" ]    ; then
          icon=" 󰁺 " # f007a
        elif [ $battery_percent -le "25" ]  ; then
          icon=" 󰁻 " # f007b
        elif [ $battery_percent -le "50" ]  ; then
          icon=" 󰁾 " # f007e
        elif [ $battery_percent -le "75" ]  ; then
          icon=" 󰁾 " # f0080
        elif [ $battery_percent -le "100" ] ; then
          icon=" 󰁹 " # f0079
        fi
        if [ "$SHOW_BATTERY_LABEL" = true ] ; then
          label="$battery_percent%%" # double % or lemonbar will complain
        fi
        ;;
      "Not charging")
        icon=" 󱟨 " # f17e8
        label="$battery_percent%%" # double % or lemonbar will complain
        ;;
      "Unknown")
        icon=" 󰂑 " # f0091
        label="?"
        ;;
      "Full")
        icon=" 󰁹 " # f0079
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

