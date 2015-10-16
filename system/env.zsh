#
# This file store system-wide configurations, basically everything
# you would put in .bashrc or .zshrc but independent from# the console
# you use.
#

# set default editor
export EDITOR='vim'

# use 256 colors terminal
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
 export TERM='xterm-256color'
else
 export TERM='xterm-color'
fi

