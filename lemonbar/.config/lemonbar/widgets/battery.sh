#!/bin/bash


battery() {
  while :; do
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
    battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
    
    case "$battery_status" in
      "Charging")
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
      "Discharging")
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
      "Not charging")
        icon="  "
        label="$battery_percent%%" # double % or lemonbar will complain
        ;;
      "Unknown")
        icon="  "
        label="?"
        ;;
      "Full")
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

