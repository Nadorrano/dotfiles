#!/usr/bin/env bash
# credit: http://nparikh.org/notes/zshrc.txt
# Usage: extract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific and was remove,
# added other linux iso mounting methods
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.iso)      mount $1 /mnt                       ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


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

