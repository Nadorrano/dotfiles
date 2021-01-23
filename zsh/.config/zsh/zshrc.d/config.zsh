#
# General configurations 
#

export EDITOR="vim"


# Set terminal window title
DISABLE_AUTO_TITLE="true"
autoload -Uz add-zsh-hook
_set_title () { print -Pn "\e]2;%n@%M  %~\a" }
add-zsh-hook -Uz precmd _set_title 

# Enable powerline
powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

# Command not found hook for zsh (need package 'pkgfile')
source /usr/share/doc/pkgfile/command-not-found.zsh

# Load custom functions
autoload -Uz extract


#
# History
#

HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# adds history incrementally and share it across sessions
setopt SHARE_HISTORY
# expand !! before executing the command
setopt HIST_VERIFY 
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
# remove extra blank for history entries
setopt HIST_REDUCE_BLANKS
# No annoying sounds 
setopt NO_BEEP
# Command correction
setopt CORRECT
# Ignore EOF, Ctrl-D 
setopt IGNORE_EOF


#
# Aliases 
#

alias reload!='source $ZDOTDIR/.zshrc'

source $DOTFILES/system/aliases.sh

