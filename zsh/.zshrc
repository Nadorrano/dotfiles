#
# ~/.zshrc
#

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# all of our config files
typeset -U config_files
config_files=($DOTFILES/**/*.(sh|zsh))

# load the path files
for file in ${(M)config_files:#*/path.(sh|zsh)}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

# Command not found hook for zsh
# (need package 'pkgfile')
source /usr/share/doc/pkgfile/command-not-found.zsh

unset config_files


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



#
# key mapping for zsh
#

# emacs-like keybindings
bindkey -e

# Read terminfo
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


# Bind ctrl-left / ctrl-right
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

# History search, backwards and forwards, based upon what
# has already been entered at the prompt
bindkey "$key[Up]" history-beginning-search-backward
bindkey "$key[Down]" history-beginning-search-forward

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



# Let's have some colors first
autoload -U colors && colors

if [[ -e /usr/bin/powerline ]]; then
  # Powerline support is enabled if available, otherwise use a regular PS1
  . `python -c "import powerline;import inspect;import os;print(os.path.dirname(inspect.getfile(powerline)))"`/bindings/zsh/powerline.zsh 
  VIRTUAL_ENV_DISABLE_PROMPT=true
else
  # Default colors:
  # Cyan for users, red for root, magenta for system users
  local _time="%{$fg[yellow]%}[%*]"
  local _path="%B%{$fg[green]%}%(8~|...|)%7~"
  local _usercol
  if [[ $EUID -lt 1000 ]]; then
    # red for root, magenta for system users
    _usercol="%(!.%{$fg[red]%}.%{$fg[magenta]%})"
  else
    _usercol="$fg[cyan]"
  fi
  local _user="%{$_usercol%}%n@%M"
  local _prompt="%{$fg[white]%}${(r:$SHLVL*2::%#:)}"
  
  PROMPT=$'$_time $_user $_path $_prompt%b%f%k ${vcs_info_msg_0_}\n› '

  # RPROMPT='${vcs_info_msg_0_}' # git branch
  if [[ ! -z "$SSH_CLIENT" ]]; then
    RPROMPT="$RPROMPT ⇄" # ssh icon
  fi
fi






#
# Alias
#

alias reload!='. ~/.zshrc'

alias vi='vim'





# List all orphan packages
alias pacorphan="pacman -Qtdq"

# List foreign packages

alias pacforeign="pacman -Qm"

# List all packages installed by date
# add --desc to get the description of the package
pacdate () {
  if [[ "$1" == '--desc' ]]; then
    awk '/%NAME%/{getline;PKG=$1} /%INSTALLDATE%/{getline
    IDATE=strftime("%Y-%m-%d %H:%M",$1)} /%DESC%/{getline; DESC=$0
    print IDATE" "PKG" -- "DESC}' /var/lib/pacman/local/*/desc|sort
  else
    awk '/%NAME%/{getline;PKG=$1} /%INSTALLDATE%/{getline
    IDATE=strftime("%Y-%m-%d %H:%M",$1)
    print IDATE" "PKG}' /var/lib/pacman/local/*/desc|sort
  fi
}

