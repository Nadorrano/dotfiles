
if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

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
setopt HIST_VERIFY
# share history between sessions ???
setopt SHARE_HISTORY
# add timestamps to history
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
# adds history
setopt APPEND_HISTORY
# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY SHARE_HISTORY
# don't record dupes in history
setopt HIST_IGNORE_ALL_DUPS
# remove extra blank for history entries
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

zle -N newtab

