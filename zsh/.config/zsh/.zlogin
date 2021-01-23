# Start X server
# WARNING: your system probably uses a different method
# to start the X Server and you probably want to comment the
# next line.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

