# 
# .zshenv
#

# zsh config directory
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/.dotfiles"

# Add ~/.local/bin to PATH
typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

export EDITOR="vim"
export PAGER="less"

# Syntax highlighting
export HIGHLIGHT_STYLE=zenburn

# Load secret environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

