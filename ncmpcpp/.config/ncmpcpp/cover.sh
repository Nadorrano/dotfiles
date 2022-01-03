#!/usr/bin/env bash

#-------------------------------#
# Display current cover         #
#-------------------------------#

source "`ueberzug library`"

COVER="/tmp/album_cover.png"
X_PADDING=2
Y_PADDING=1

function add_cover() {
  if [ ! -f "$COVER" ] ; then
    cp ~/.config/ncmpcpp/default_cover.png "$COVER"
  fi
  ImageLayer::add [identifier]="cover" [x]="$X_PADDING" [y]="$Y_PADDING" [path]="$COVER"
}

function remove_cover() {
  ImageLayer::remove [identifier]="cover"
}

function you_wait() {
  while inotifywait -q -q -e close_write "$COVER"; do
    add_cover
  done
}

clear

ImageLayer 0< <(
  add_cover
  you_wait
)

