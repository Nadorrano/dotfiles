#!/usr/bin/env bash
#
# ~/.bashrc
#

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
 
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# prompt style
PS1='[\u@\h \W]\$ '  # To leave the default one

# Command-not-found for bash (Arch Linux)
source /usr/share/doc/pkgfile/command-not-found.bash

# bash non-repeating history
export HISTCONTROL=ignoreboth:erasedups

# all of our config files
config_files=`find $DOTFILES -maxdepth 2 -type f \( -name "*.sh" -o -name "*.bash" \)`

 
# load the path files
for file in $config_files
do
  if [[ $( basename $file ) =~ path\.(ba)*sh$ ]]; then
    source $file
  fi
done

# load everything but the path files
for file in $config_files
do
 if [[ ! $( basename $file ) =~ path\.(ba)*sh$ ]]; then
   source $file
 fi
done

# Stash your environment variables in ~/.localrc. This means they'll stay out
# of your main dotfiles repository (which may be public, like this one), but
# you'll have access to them in your scripts.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

# bash autocompletion
for file in /usr/local/etc/bash_completion.d/*
do
  source $file
done

