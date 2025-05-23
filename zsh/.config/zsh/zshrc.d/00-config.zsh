#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#   _ / /\__ \ | | | | | (__
#  (_)___|___/_| |_|_|  \___|
#  
#  General configuration
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]
then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add the function folder to fpath
fpath=( "${XDG_DATA_HOME:-$HOME/.local/share}/functions" "${fpath[@]}" )

# Load hook function
autoload -Uz add-zsh-hook
# Load custom functions
autoload -U "${XDG_DATA_HOME:-$HOME/.local/share}/functions"/*(@,.:t)

# Set terminal window title
function xterm_title_precmd () {
  print -Pn -- '\e]2;%n@%M  %~\a'
  [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e]2;%n@%M  %~\a\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

[[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|st*|tmux*|xterm*) ]] &&
  add-zsh-hook -Uz precmd xterm_title_precmd

# Colored correction prompt
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Auto ls
#add-zsh-hook -Uz chpwd (){ exa; }

#
# Plugins
#

# Command-not-found for zsh (it needs package 'pkgfile')
[[ -r "/usr/share/doc/pkgfile/command-not-found.zsh" ]] && 
  source "/usr/share/doc/pkgfile/command-not-found.zsh"

# Fish-like autosuggestion
[[ -r "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && 
  source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Syntax highlighting
[[ -r "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]   && 
  source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# FZF completions
[[ -r "$ZDOTDIR/plugins/fzf-zsh-completions/fzf-zsh-completions.plugin.zsh" ]]   && 
  source "$ZDOTDIR/plugins/fzf-zsh-completions/fzf-zsh-completions.plugin.zsh"

# k for zsh
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/k/k.sh"

# Powerlevel10k prompt
source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -r ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Autopair
source "$ZDOTDIR/plugins/zsh-autopair/autopair.zsh"
autopair-init


#
# History
#

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE

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

# Change cursor shape for different vi modes.
function zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;      # block
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select

echo -ne '\e[5 q' # Use beam shape cursor on startup.

#
# Aliases
#

# Alias to reload the shell
alias reload!="source $ZDOTDIR/.zshrc"

# Load aliases from the alias directory
alias_dir="${XDG_DATA_HOME:-$HOME/.local/share}/aliases"
if [[ -d "$alias_dir" ]]; then
  for alias_file in "$alias_dir"/*.sh; do
    [ -r "$alias_file" ] && source "$alias_file"
  done
fi

