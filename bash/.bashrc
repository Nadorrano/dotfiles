#!/usr/bin/env bash

#      _               _
#     | |__   __ _ ___| |__  _ __ ___
#     | '_ \ / _` / __| '_ \| '__/ __|
#    _| |_) | (_| \__ \ | | | | | (__
#   (_)_.__/ \__,_|___/_| |_|_|  \___|
#


# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
export EDITOR="vim"

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Autocorrects cd misspellings
shopt -s cdspell

# Command-not-found for bash (need package 'pkgfile')
[[ -f "/usr/share/doc/pkgfile/command-not-found.bash" ]] && 
  source "/usr/share/doc/pkgfile/command-not-found.bash"

#
# History
#

# History search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/bash_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
# non-repeating history
HISTCONTROL=ignoreboth

#
# Functions
#

for f in "${XDG_DATA_HOME:-$HOME/.local/share}/functions"/* ; do
  source "$f"
done

#
# Autocompletion
#

[[ -f "/usr/share/bash-completion/bash_completion" ]] && 
  source "/usr/share/bash-completion/bash_completion"

bind "set completion-ignore-case on" # Ignore case in completion

#
# Alias
#
alias reload!="source $HOME/.bash_profile"

# ls aliases
alias ls='ls --color=auto' 
alias la='ls -A' 
alias ll='ls -GlFhA'

# execute last command again, using sudo
alias fuck='sudo $(fc -nl -1)'

# colorized grep
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Launch default editor
alias e='$EDITOR'

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias :q='exit'

