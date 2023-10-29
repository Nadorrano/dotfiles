
#      _               _
#     | |__   __ _ ___| |__  _ __ ___
#     | '_ \ / _` / __| '_ \| '__/ __|
#    _| |_) | (_| \__ \ | | | | | (__
#   (_)_.__/ \__,_|___/_| |_|_|  \___|
#


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# shortcut to this dotfiles path is $DOTFILES
DOTFILES="$HOME/.dotfiles"
 
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
# append to history file
shopt -s histappend
# setup file in the cache directory
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/bash/bash_history"
# size of history
HISTSIZE=10000
# size of history on disk
HISTFILESIZE=$HISTSIZE
# non-repeating history
HISTCONTROL=ignoreboth
# immediately save history
PROMPT_COMMAND='history -a'
# do not save these
HISTIGNORE="history:ls:pwd:sudo rm *"


#
# Functions
#

for f in "${XDG_DATA_HOME:-$HOME/.local/share}/functions"/* ; do
  . "$f"
done


#
# Autocompletion
#

if [[ -f /usr/share/bash-completion/bash_completion ]]; then 
  . /usr/share/bash-completion/bash_completion
fi

bind "set completion-ignore-case on" # Ignore case in completion

# Reload the shell
alias reload!="source $HOME/.bash_profile"

if [[ -f ~/.aliases ]]; then . ~/.aliases; fi

