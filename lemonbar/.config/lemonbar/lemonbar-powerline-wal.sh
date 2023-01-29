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

# ----------------------------------- #
#                                     #
#            Configuration            #
#                                     #
# ----------------------------------- #

# show labels next to icons
SHOW_VOLUME_LABEL=true
SHOW_BATTERY_LABEL=true
SHOW_NETWORK_LABEL=true
SHOW_USER=true

# fonts
font1="FantasqueSansMono Nerd Font:size=9.5"    # main font
font2="xos4 Terminess Powerline:size=12"        # Powerline symbols font

# section separators
righthard="%{T2}%{T-} "
rightsoft="%{T2}%{T-} "
lefthard=" %{T2}%{T-}"
leftsoft=" %{T2}%{T-}"

WIDGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/lemonbar/widgets"


# ----------------------------------- #
#                                     #
#                Init                 #
#                                     #
# ----------------------------------- #

# load colors
. "${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors.sh"

# load widgets
. "${WIDGET_DIR}"/app_menu.sh
. "${WIDGET_DIR}"/workspace.sh
. "${WIDGET_DIR}"/windows.sh
. "${WIDGET_DIR}"/network.sh
. "${WIDGET_DIR}"/sound.sh
. "${WIDGET_DIR}"/battery.sh
. "${WIDGET_DIR}"/calendar.sh
. "${WIDGET_DIR}"/clock.sh
. "${WIDGET_DIR}"/power_menu.sh

# setup the FIFO
PANEL_FIFO="/tmp/panel.fifo"

[[ -e "$PANEL_FIFO" ]] && rm "$PANEL_FIFO"

mkfifo "$PANEL_FIFO"


# ----------------------------------- #
#                                     #
#             Launch bar              #
#                                     #
# ----------------------------------- #

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
    string="%{l B$color2 F$color7}${men}%{RB$color5}$righthard"
    string+="${wsp}%{F$color5 B$color0}$righthard"
    string+="%{B$color0 F$color7}${win}"
    string+="%{r F$color5}$lefthard%{RF$color0}${net}"
    string+="%{F$color2}$lefthard%{RF$color0}${vol}"
    string+="%{F$color5}$lefthard%{RF$color0}${bat}"
    string+="%{F$color2}$lefthard%{RF$color0}${dat}"
    string+="%{F$color5}$lefthard%{RF$color0}${tim}"
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
panel_builder < "$PANEL_FIFO" | lemonbar -g x18 -p -a 20                \
                                         -f "${font1}" -f "${font2}"    \
                                         -B "${color0}" -F "${color4}"  |
                                         sh > /dev/null & 

