# Git plugin

autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:(git*):*" get-revision true
zstyle ":vcs_info:(git*):*" check-for-changes true

local _branch="%c%u%m %{$fg[green]%}%b%{$reset_color%}"
local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
local _action="%{$fg[red]%}%a%{$reset_color%}"
zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
zstyle ":vcs_info:git*" formats "$_branch:$_revision - $_repo"
zstyle ":vcs_info:git*" actionformats "$_branch:$_revision:$_action - $_repo"
zstyle ':vcs_info:git*+set-message:*' hooks git-stash
# Uncomment to enable vcs_info debug mode
# # zstyle ':vcs_info:*+*:*' debug true

function +vi-git-stash() {
  if [[ -s "${hook_com[base]}/.git/refs/stash" ]]; then
    hook_com[misc]="%{$fg_bold[grey]%}~%{$reset_color%}"
  fi
}

precmd() {
  vcs_info
}

