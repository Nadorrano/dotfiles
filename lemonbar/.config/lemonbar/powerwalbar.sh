#!/bin/bash

#  _                                _
# | |                              | |
# | |     ___ _ __ ___   ___  _ __ | |__   __ _ _ __
# | |    / _ \ '_ ` _ \ / _ \| '_ \| '_ \ / _` | '__|
# | |___|  __/ | | | | | (_) | | | | |_) | (_| | |
# |______\___|_| |_| |_|\___/|_| |_|_.__/ \__,_|_|
#
# Launcher
#


pkill lemonbar

# load wal colors
. ~/.cache/wal/colors.sh

# load widgets
. ~/.config/lemonbar/widgets.sh

# config
SHOW_VOLUME_LABEL=true
SHOW_BATTERY_LABEL=true
SHOW_NETWORK_LABEL=true

# fonts
f1="Meslo LG M:size=9"
f2="OverpassMono Nerd Font:size=9.5"

# powerbar symbols
righthard=""
rightsoft=""
lefthard=""
leftsoft=""

# setup the FIFO
PANEL_FIFO="/tmp/panel.fifo"

[[ -e "$PANEL_FIFO" ]] && rm "$PANEL_FIFO"

mkfifo "$PANEL_FIFO"

panel_builder() {
  while read -r data; do
    case "$data" in
      MEN*)                   # dropdown menu
        men="${data#???}"
        ;;
      WSP*)                   # workspace selector
        wsp="${data#???}"   
        ;;
      WIN*)                   # current window title
        win="${data#???}"
        ;;
      NET*)                   # network
        net="${data#???}"
        ;;
      VOL*)                   # volume
        vol="${data#???}"
        ;;
      BAT*)                   # battery
        bat="${data#???}"
        ;;
      DAT*)                   # date
        dat="${data#???}"
        ;;
      TIM*)                   # time
        tim="${data#???}"
        ;;
      POW*)                   # power off
        pow="${data#???}"
        ;;
    esac
    string="%{l B$color2 F$color7}${men}%{RB$color4}$righthard"
    string+="${wsp}%{F$color4 B$color0}$righthard"
    string+="%{B$color0 F$color7}${win}"
    string+="%{r F$color4}$lefthard%{RF$color0}${net}"
    string+="%{F$color2}$lefthard%{RF$color0}${vol}"
    string+="%{F$color4}$lefthard%{RF$color0}${bat}"
    string+="%{F$color2}$lefthard%{RF$color0}${dat}"
    string+="%{F$color4}$lefthard%{RF$color0}${tim}"
    string+="%{F$color2}$lefthard%{RF$color0}${pow}%{B-F-}"
    echo $string
  done
}


menu        >  "$PANEL_FIFO"  & 
get_ws      >  "$PANEL_FIFO"  &
get_window  >  "$PANEL_FIFO"  &
network     >  "$PANEL_FIFO"  &
volume      >  "$PANEL_FIFO"  &
battery     >  "$PANEL_FIFO"  &
power_icon  >  "$PANEL_FIFO"  &
calendar    >  "$PANEL_FIFO"  &
clock       >  "$PANEL_FIFO"  &

# launch lemonbar
panel_builder < "$PANEL_FIFO" | lemonbar -g x18 -p -a 20            \
                                         -f "${f1}" -f "${f2}"      \
                                         -B "$color0" -F "$color4"  \
                                          | sh > /dev/null & 

