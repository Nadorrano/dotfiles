#
# Aliases 
#

# Enable aliases to be sudo’ed
alias sudo='sudo '

# ls aliases
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

alias :q='exit'
alias mkdir='mkdir -p'
alias ip='ip --color=auto --brief'
alias diff='diff --color=auto'
alias week='date +%V'
alias df='df -h'

alias disappointed='echo -n " ಠ_ಠ " |tee /dev/tty| xclip -selection clipboard;'
alias flip='echo -n "（╯°□°）╯ ┻━┻" |tee /dev/tty| xclip -selection clipboard;'
alias shrug='echo -n "¯\_(ツ)_/¯" |tee /dev/tty| xclip -selection clipboard;'

# git
alias ga='git add'
alias gst='git status'
alias gd='git diff'
alias gl='git log'
alias gr='cd "$(git rev-parse --show-superproject-working-tree --show-toplevel | head -n1)"'


# Load secret environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

