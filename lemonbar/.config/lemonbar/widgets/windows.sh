#!/bin/bash


get_window() {
  while :; do
	  window_title=$(echo -n "$(xdotool getwindowfocus getwindowname)"  | 
      awk -v l=61 '{if (length($0) > l) $0=substr($0, 1, l-3) "...";print;}')
    echo "WIN%{A:dmenu_windows:}  $window_title %{A}" # f2d0
    sleep 3
  done
}

