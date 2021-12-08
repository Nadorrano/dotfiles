############################
#                          #
#   Pacman configuration   #
#                          #
############################

#
# Alias
#
alias pacorphan='pacman -Qtdq'
alias pacforeign='pacman -Qqm'

# List packages (requires fzf) 
alias pacs='pacman -Slq | fzf --multi --preview "pacman -Si {1}" | xargs -ro echo'
alias pacq='pacman -Qq | fzf --multi --preview "pacman -Qi {1}" | xargs -ro echo'

# pacman zsh completion
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

