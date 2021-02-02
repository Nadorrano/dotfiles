# 
# .zshenv
#

# zsh config directory
ZDOTDIR="$HOME/.config/zsh"

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# Load secret environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

