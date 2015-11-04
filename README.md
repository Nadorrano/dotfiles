# my dotfiles

## dotfiles

These are my dotfiles. I started to store them here to have a backup for me and maybe to offer a source of inspiration for others. These dotfiles are meant to be compatible with various linux systems with little modifications.

I forked this repo from [Zach Holman one](https://github.com/holman/dotfiles).

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read his post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

In brief, to *use* this, you have to fork/copy/download/steal these dotfiles and personalize them for your system(s).

## install

Before installing you need to be sure that the new dotfiles will not broke your system configuration. In particular you need to pay attention to 
`system/xinitrc.symlink`, `bash/bash_profile.symlink`, `zsh/zlogin.symlink`
 which contains directives specific to the desktop environment that I use (xfce). The safest choice is to delete those file before running `script/bootstrap` (see next).

To install these .dotfiles run this:

```sh
git clone https://github.com/Nadorrano/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
git submodule init --recursive
git submodule update
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directy and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

Inside there are some components inherited from 
[Zach Holman's github](https://github.com/holman/dotfiles) and some other 
original stuff. If you like something in this repo, 
[fork it](https://github.com/Nadorrano/dotfiles/fork), 
remove what you don't use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.{sh, zsh, bash, tcsh}**: Any files ending in `.zsh`, `.bash`,
 `.tcsh` get loaded into your environment by the corresponding rc file
 of the shell you use. `.sh` files are loaded both by bash and zsh.
- **topic/path.{sh, zsh, bash, tcsh}**: Any file named `path.{sh, zsh, bash, tcsh}` is loaded first and is expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete for zsh.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

In summary `.sh` files are loaded both by zsh and bash, `.zsh` files are loaded by zsh and `bash` files are loaded by bash; `.tcsh` files are loaded by tcsh exclusively.

The C console tcsh loads `~/.localtcshrc` while bash and zsh load `~/.localrc`, for your private configurations.

It's imperative to write portable code in all `.sh` scripts.

## description

The biggest part of this repo isn't coded by me. I tried to credit the original author directly in the file, where possible.
In this section I'll try to describe some of original contents of this script collection.

#### pacgroup

If I knew that I was going to install a bunch of packages that I know 
will be removed in a recent future I usually took a note of the 
temporary packages in some txt file. Every time I forgot where I put the
note or I entirely forgot of the packages installed. Most package managers
does not let you to save a group of packages so I wrote a little 
script that allows you to do it. You can find **pacgroup** in the `\bin` folder. 
If you install the whole repo it's already available in your `$PATH`.
This utility is thinked to be used with the Archlinux package manager **pacman** 
but it's really easy to convert it to be used with other package managers.


To create a new group:

```sh
$ pacgroup --create mygroup package1 package2 ...
```

You can see the group you just created and the files contained in it with the `--list` option:
```sh
$ pacgroup --list

mygroup

$ pacgroup --list mygroup

package1
package2

```

To delete the reference to the group created (installed packages will not be actually removed) the `--delete` option is used. This will ask for a confirmation.

```sh
$ pacgroup --delete mygroup

This will delete group 'mygroup'. Installed packages will not be removed.
Are you sure? (y/n)
``` 

To actually install/remove packages you can use the standard `pacman` command line arguments with `pacgroup` (*i.e.* `pacgroup -Sy mygroup`, `pacman -Rs mygroup`).
The group name will be expanded and all arguments passed to `pacman`.

Use this utility without `sudo`.

## disclaimer

These are my personalized dotfiles and will not work on every system. To avoid problems copy the folder/file of interest and browse the source code deleting everything you don't understand. This is a good practice. 

## thanks

I forked [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and modified for my needings so all credits go to him.

 
