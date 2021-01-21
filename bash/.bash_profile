#
# ~/.bash_profile
#

# source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X server via startx
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
