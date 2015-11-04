#
# key mapping for zsh
#

typeset -g -A key

key[F1]=''
key[F2]='^[OQ'
key[F3]='^[OR'
key[F4]='^[OS'
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]='^[[19~'
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]=''
key[F12]='^[[24~'
key[Backspace]='^?'
key[Insert]='^[[2~'
key[Home]='^[OH'
key[PageUp]='^[[5~'
key[Delete]='^[[3~'
key[End]='^[OF'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Left]='^[[D'
key[Down]='^[[B'
key[Right]='^[[C'
key[Menu]=''

#  actually bind the keys
bindkey "${key[Home]}"          beginning-of-line
bindkey "${key[End]}"           end-of-line
bindkey "${key[Insert]}"        overwrite-mdoe
bindkey "${key[Delete]}"        delete-char
bindkey "${key[Up]}"            history-search-backward #up-line-or-history
bindkey "${key[Down]}"          history-search-forward # down-line-or-history
bindkey "${key[Left]}"          backward-char
bindkey "${key[Right]}"         forward-char

# Back to previous folder: Alt + LeftArrow
# Up to parent folder: Alt + UpArrow

setopt autopushd pushdsilent pushdtohome

cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
  echo
  ls
  echo
}

zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey

