#
# Autocompletion
#

autoload -Uz compinit && compinit

# Autocompletion of privileged environments
zstyle ':completion::complete:*' gain-privileges 1

# Matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pacman 
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Print waiting dots while completing
expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}

zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt COMPLETE_ALIASES
# Complete from the inside of a word
setopt COMPLETE_IN_WORD

