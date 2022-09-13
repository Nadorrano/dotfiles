#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#   _ / /\__ \ | | | | | (__
#  (_)___|___/_| |_|_|  \___|
#  
#

# If not running interactively, don't do anything
[[ $- =~ i ]] || return

for config_file in $ZDOTDIR/zshrc.d/*.zsh; do
  source $config_file
done

