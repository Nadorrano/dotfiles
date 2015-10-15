#
# This script contains useful functions to use with the
# Archlinux package manager "pacman".
#


# List all packages installed by date

pacdate () {
  awk '/%NAME%/{getline;PKG=$1} /%INSTALLDATE%/{getline
  IDATE=strftime("%Y-%m-%d %H:%M",$1)
  print IDATE" "PKG}' /var/lib/pacman/local/*/desc|sort
}