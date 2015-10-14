#
# This script contains useful functions to use with the
# Archlinux package manager "pacman".
#

# ---- Configurable Options -------------------------------

# storage dir for pacgroups
pacgroup_dir=$HOME/.pacgroups

# ---------------------------------------------------------




# List all packages installed by date

pacdate () {
  awk '/%NAME%/{getline;PKG=$1} /%INSTALLDATE%/{getline
  IDATE=strftime("%Y-%m-%d %H:%M",$1)
  print IDATE" "PKG}' /var/lib/pacman/local/*/desc|sort
}

# Implements pacman groups. With this function you can
# create groups of packages that cahat can be installed/removed together

pacgroup () {
  if [[ $EUID -eq 0 ]]; then
    echo "This script must not be run as root." 1>&2
    return 1
  fi
  usage="Usage: pacgroup [option|pacman args] [pacgroup name]"
  help="$usage

  This script can be used to install remove/packages via pacman. You can create
  groups of packages to batch install/remove them with one short command. It 
  does accept command line arguments and pass them to pacman after the
  reference to the group has been expanded. You can thus install a group of 
  packages by simply wrote 'sudo pacgroup -Sy my_program_dependencies'.

  Extra Options:
      --list [pacgroup]                  List all pacgroups, if a packgroup is
                                         given as argument, returns the list of
                                         packages in the group.
      --create [pacgroup] [packages]     Create a new group of packages with
                                         name 'packgroup'.
      --delete [pacgroup]                Delete a group of packages. Does not
                                         actually remove any program from the
                                         system.
      --help                             Print this help. 
  "
  if [[ $# -eq 0 ]] ; then
    echo $usage
    return 0
  fi
  if [ ! -d $pacgroup_dir ]; then
    mkdir $pacgroup_dir
    echo "Directory $pacgroup_dir created."
  fi
  case $1 in
        '--list')
                if [ ! $2 ]; then
                  for f in "$pacgroup_dir"/*
                    do
                      echo $(basename $f)
                    done   
                    return 0;       
                fi
                if [ ! -f "$pacgroup_dir/$2" ]; then
                  echo "No groups found with name '$2'" 1>&2
                  return 1;
                fi
                cat "$pacgroup_dir/$2" | tr '\n' ' ' | sed -r 's/\s+/\n/g'
        ;;
        '--create')
                if [ -f "$pacgroup_dir/$2" ]; then
                  echo "Group $2 already exists."
                  read -q "REPLY?Overwrite? (y/n)" -n 1 -r
                  if [[ ! $REPLY =~ ^[Yy]$ ]]
                  then
                    return 0;
                  fi
                fi
                echo "${@:3}\n" > "$pacgroup_dir/$2"
        ;; 
        '--delete')
                if [ ! -f "$pacgroup_dir/$2" ]; then
                  echo "No groups found with name: $2" 1>&2
                  return 1;
                fi
                echo "This will delete group $2. Installed packages will not be removed."
                read -q "REPLY?Are you sure? (y/n)" -n 1 -r
                if [[ $REPLY =~ ^[Yy]$ ]]
                then
                  rm "$pacgroup_dir/$2"
                  echo "Group $2 deleted."
                fi
                ;;
        '--help')
              echo $help
              ;;
        *)
              if [ ! -f "$pacgroup_dir/$2" ]; then                            
                echo "No groups found with name: $2"                          
                return 1;
              fi
              # very simple approach
              sudo pacman $1 - < "$pacgroup_dir/$2"
              ;;
  esac
}

export pacgroup

