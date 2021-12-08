#!/bin/bash

#  _                                _
# | |                              | |
# | |     ___ _ __ ___   ___  _ __ | |__   __ _ _ __
# | |    / _ \ '_ ` _ \ / _ \| '_ \| '_ \ / _` | '__|
# | |___|  __/ | | | | | (_) | | | | |_) | (_| | |
# |______\___|_| |_| |_|\___/|_| |_|_.__/ \__,_|_|
#
#  github.com/fikriomar16

pkill lemonbar

. ~/.cache/wal/colors.sh

. ~/.config/lemonbar/widgets.sh

#f1="FontAwesome 5 Free:style=Solid:size=9"
#f1="Material Icons:size=10"
#f1="NotoSansDisplay Nerd Font:size=10"
#f1="NotoSansMono Nerd Font:size=10"
#f1="NotoSerif Nerd Font:size=10"
#f1="RobotoMono Nerd Font:size=11"
#f2="Arimo for Powerline:size=10"
#f2="monofur for Powerline:size=11"
#f2="FantasqueSansMono Nerd Font:size=10"
#f1="OverpassMono Nerd Font:size=10"
#f2="Tinos for Powerline:size=11"
f2="LiterationSerif Nerd Font:size=11"
f1="iMWritingDuospace Nerd Font:size=9"
#f1="Arimo Nerd Font:size=11"
#f2="LiterationSans Nerd Font:size=11"
#f1="Ubuntu Nerd Font:size=11"
#f1="iMWritingMonos Nerd Font:size=10"

righthard=""
rightsoft=""
lefthard=""
leftsoft=""


while true; do
    string=" 
    %{l}%{B$color2}%{F$color7}$(menu)%{RB$color4}$righthard
    $(get_ws)%{F$color4}%{B$color0}$righthard
    %{B$color0}%{F$color7}$(get_window)
    %{r}%{F$color4}$lefthard%{RF$color0}$(network)
    %{F$color2}$lefthard%{RF$color0}$(volume)
    %{F$color4}$lefthard%{RF$color0}$(battery)
    %{F$color2}$lefthard%{RF$color0}$(calendar) 
    %{F$color4}$lefthard%{RF$color0}$(clock)
    %{F$color2}$lefthard%{RF$color0}$(power_icon)%{B-}%{F-}"
    echo -n $string
    sleep 1
done | lemonbar -g x18 -p -f "${f1}" -f "${f2}" -B "$color0" -F "$color4" -a 20  | sh & > /dev/null

