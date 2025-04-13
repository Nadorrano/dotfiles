# 
# .zshenv
#

# TexLive
export PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux
export MANPATH=$MANPATH:/usr/local/texlive/2023/texmf-dist/doc/man
export INFOPATH=$INFOPATH:/usr/local/texlive/2023/texmf-dist/doc/info

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

