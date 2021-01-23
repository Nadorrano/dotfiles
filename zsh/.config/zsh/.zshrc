#
# ~/.zshrc
#

for config_file in $ZDOTDIR/zshrc.d/*.zsh; do
  source $config_file
done

