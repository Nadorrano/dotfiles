#
# ~/.zshrc
#

export EDITOR="vim"

# Set terminal window title
DISABLE_AUTO_TITLE="true"
precmd () { print -Pn "\e]2;%n@%M | %~\a" }


#
# Autocompletion
#

autoload -Uz compinit
compinit

# Autocompletion of privileged environments
zstyle ':completion::complete:*' gain-privileges 1


# Command not found hook for zsh (need package 'pkgfile')
source /usr/share/doc/pkgfile/command-not-found.zsh

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true


#
# History
#

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_VERIFY
# share history between sessions ???
setopt SHARE_HISTORY
# add timestamps to history
setopt EXTENDED_HISTORY
# adds history
setopt APPEND_HISTORY
# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY SHARE_HISTORY
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
# remove extra blank for history entries
setopt HIST_REDUCE_BLANKS

# Go to a folder without 'cd'
setopt AUTO_CD

# don't nice background tasks
setopt NO_BG_NICE 
setopt NO_HUP
setopt NO_LIST_BEEP
# allow functions to have local options
setopt LOCAL_OPTIONS
# allow functions to have local traps
setopt LOCAL_TRAPS 
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt COMPLETE_ALIASES

zle -N newtab


#
# Aliases and functions
#

alias reload!='. ~/.zshrc'

source $DOTFILES/system/aliases.sh
source $DOTFILES/system/functions.sh

