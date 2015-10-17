# List all orphan packages
alias pacorphan="pacman -Qtdq"

# List foreign packages

alias pacforeign="pacman -Qm"

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

