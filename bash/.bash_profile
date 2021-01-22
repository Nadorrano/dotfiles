#
# ~/.bash_profile
#

source $HOME/.dotfiles/system/env.sh

# source bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X server via startx
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

