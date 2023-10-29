# 
# .zprofile
#

# Exports
export PATH=$PATH:$HOME/.local/bin
export EDITOR="vim"
export PAGER="less"

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES="$HOME/.dotfiles"

# Add ~/.local/bin to PATH
typeset -U PATH path
path=("$HOME/.local/bin" "$path[@]")
export PATH

# zsh config directory
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Syntax highlighting
export HIGHLIGHT_STYLE=zenburn

