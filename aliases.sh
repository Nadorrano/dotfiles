#
# Store here all aliases that not depend on the shell used and 
# does not belong to any topic folder.
#

# ls aliases
alias ls='ls --color=auto' 
alias la='ls -A' 
alias ll='ls -GlFhA'

# execute last command again, using sudo
alias fuck='sudo $(fc -nl -1)'

# colored grep
alias grep='grep --color'

# Launche default editor
alias e='$EDITOR'

# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Bumblebee
# Use gpu for rendering (if optirun is not working) for nvidia hardware
# from user flecha https://bbs.archlinux.org/viewtopic.php?id=184571 
function use_gpu { xrandr --setprovideroffloadsink nvidia Intel;  DRI_PRIME=1 $@; }

