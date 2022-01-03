#!/usr/bin/env bash

#-------------------------------#
# Search album cover            #
#-------------------------------#

COVER="/tmp/album_cover.png"
COVER_SIZE="300"
MUSIC_DIR="$HOME/Musica"
FALLBACK_IMAGE="$HOME/.config/ncmpcpp/default_cover.png"


kill_previous_instances() {
  script_name=$(basename "$0")
  for pid in $(pidof -x "$script_name"); do
    if [ "$pid" != $$ ]; then
        kill -15 "$pid"
    fi 
  done
}


find_cover_image() {
  # First we check if the audio file has an embedded album art
  ext="$(mpc --format %file% current | sed 's/^.*\.//')"
  if [ "$ext" = "flac" ]; then
    # since FFMPEG cannot export embedded FLAC art we use metaflac
    metaflac --export-picture-to=/tmp/mpd_cover.jpg \
      "$(mpc --format "$MUSIC_DIR"/%file% current)" &&
      cover_path="/tmp/mpd_cover.jpg" && return
  else
    ffmpeg -y -i "$(mpc --format "$MUSIC_DIR"/%file% | head -n 1)" \
      /tmp/mpd_cover.jpg &&
    cover_path="/tmp/mpd_cover.jpg" && return
  fi

  # If no embedded art was found we look inside the music file's directory
  album="$(mpc --format %album% current)"
  file="$(mpc --format %file% current)"
  album_dir="${file%/*}"
  album_dir="$music_library/$album_dir"
  found_covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f \
  -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\\(jpe?g\|png\|gif\|bmp\)" \; )"
  cover_path="$(echo "$found_covers" | head -n1)"
  if [ -n "$cover_path" ]; then
    return
  fi

  # If we still failed to find a cover image, we use the fallback
  if [ -z "$cover_path" ]; then
    cover_path=$FALLBACK_IMAGE
  fi
}


kill_previous_instances >/dev/null 2>&1
find_cover_image >/dev/null 2>&1
ffmpeg -loglevel 0 -y -i "$cover_path" -vf "scale=$COVER_SIZE:-1" "$COVER"

