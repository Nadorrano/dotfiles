#!/bin/bash

LABELS="Annulla
Logout
Riavvia
Spegni
"

. ~/.cache/wal/colors.sh

CHOICE=$(echo -n "$LABELS" | dmenu -nb $color0 -nf $color1 -sb $color2 -sf $color7)
case $CHOICE in
Logout) exec logout;;
Riavvia) exec reboot;;
Spegni) exec shutdown now;;
Annulla) ;;
*) ;;
esac

