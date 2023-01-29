#!/bin/bash


power_icon() {
  while :; do
    string=" 襤 "    # f924 
    if [ "$SHOW_USER" = true ] ; then
      string+=$(whoami)
    fi
    echo "POW%{A:dmenu_logout:} $string  %{A}"
    sleep 3
  done
}

