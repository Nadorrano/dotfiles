#!/usr/bin/env bash
#
# ~/.bashrc
#

export EDITOR="vim"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s cdspell # autocorrects cd misspellings

# prompt style
#PS1='[\u@\h \W]\$ '  # To leave the default one

# Command-not-found for bash 
source /usr/share/doc/pkgfile/command-not-found.bash

# bash non-repeating history
export HISTCONTROL=ignoreboth:erasedups

#
# Autocompletion
#

bind "set completion-ignore-case on" # Ignore case in completion

#
# Alias
#
source $DOTFILES/system/aliases.sh

