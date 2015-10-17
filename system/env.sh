#
# This file store system-wide configurations, basically everything
# you would put in .bash_profile or .zprofile but independent from the shell
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

# Add binaries of these dotfiles distribution to $PATH.
# Note that ~/local/bin is not added here but in ~/.localrc
# if this is needed.
export PATH="$DOTFILES/bin:$PATH"

