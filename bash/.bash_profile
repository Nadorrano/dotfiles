#
# ~/.bash_profile
#

# Exports
export PATH=$PATH:$HOME/.local/bin
export EDITOR="vim"
export PAGER="less"

# Shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/.dotfiles"

# Add ~/.local/bin to path
PATH=$PATH:$HOME/.local/bin

# Ignore EOF
export IGNOREEOF=1

# Source bashrc
if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi

# Start X server via startx
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

