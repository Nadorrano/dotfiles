#
# Store here all aliases that not depend on the console used or 
# does not belong to any topic folder.
#

# ls aliases
alias ls='ls --color=auto' 
alias la='ls -a' 
alias ll='ls -la'

# sudo alias, execute last command again, using sudo
alias fuck='sudo $(fc -nl -1)'

# colored grep
alias grep='grep --color'

# Bumblebee
# Use gpu for rendering (if optirun is not working)
# from user flecha https://bbs.archlinux.org/viewtopic.php?id=184571 
function use_gpu { xrandr --setprovideroffloadsink nvidia Intel;  DRI_PRIME=1 $@; }

