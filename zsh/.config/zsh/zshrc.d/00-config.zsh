#
# General configurations 
#

autoload -Uz add-zsh-hook

# Set terminal window title
function xterm_title_precmd () {
    print -Pn -- '\e]2;%n@%M  %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e]2;%n@%M  %~\a\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|st*|tmux*|xterm*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
fi


# Auto ls
add-zsh-hook -Uz chpwd (){ exa; }

# Enable powerline
powerline-daemon -q
. /usr/share/powerline/bindings/zsh/powerline.zsh

# Command not found hook for zsh (need package 'pkgfile')
source /usr/share/doc/pkgfile/command-not-found.zsh

# Add the function folder to fpath
fpath=( $ZDOTDIR/functions "${fpath[@]}" )

# Load custom functions
autoload -U $ZDOTDIR/functions/*(@,.:t)

#
# History
#

HISTFILE=~/.cache/zsh/zsh_history
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

#
# Misc options
#

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

# exa aliases
alias ls='ls --color=auto' 
alias la='ls -A' 
alias ll='ls -GlAh'
# List only directories
alias lsd='ls -DFl'


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

