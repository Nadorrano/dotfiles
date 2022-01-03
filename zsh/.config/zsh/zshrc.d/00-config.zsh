#
# General configurations 
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add the function folder to fpath
fpath=( $ZDOTDIR/functions "${fpath[@]}" )

# Load hook function
autoload -Uz add-zsh-hook
# Load custom functions
autoload -U "$ZDOTDIR"/functions/*(@,.:t)

# Set terminal window title
function xterm_title_precmd () {
    print -Pn -- '\e]2;%n@%M  %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e]2;%n@%M  %~\a\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

[[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|st*|tmux*|xterm*) ]] &&
  add-zsh-hook -Uz precmd xterm_title_precmd

# Auto ls
#add-zsh-hook -Uz chpwd (){ exa; }

# Command not found hook for zsh (need package 'pkgfile')
[[ -f "/usr/share/doc/pkgfile/command-not-found.zsh" ]]   && 
[[ -f "/usr/bin/pkgfile" ]]                               && 
  source "/usr/share/doc/pkgfile/command-not-found.zsh"

# Fish-like autosuggestion
[[ -f "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]   && 
  source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Syntax highlighting
[[ -f "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]   && 
  source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


#
# Prompt
#
source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


#
# History
#

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
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

# ls aliases
alias ls='ls --color=auto' 
alias la='ls -A' 
alias ll='ls -GlAh'
# List only directories
alias lsd='ls -DFl'

# visudo with vim
alias visudo='EDITOR=vim visudo'

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

