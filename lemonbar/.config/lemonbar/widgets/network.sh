#!/bin/bash


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
    echo "NET%{A:dmenu_wifi: A3:st -e nmtui:}$string%{A A}"
    sleep 30
  done
}

