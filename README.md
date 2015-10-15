# my dotfiles

## dotfiles

These are my dotfiles. I started to store them here to have a backup for me and maybe to offer a source of inspiration for others.

I forked this repo from Zach Holman one.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read his post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## install

Run this:

```sh
git clone https://github.com/Nadorrano/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
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

## description

The biggest part of this repo isn't coded by me. I tried to credit the original author directly in the file, where possible.
In this section I'll try to describe some of original contents of this script collection.

### pacgroup

If I knew that I was going to install a bunch of packages that I know 
will be removed in a recent future I usually took a note of the 
temporary packages in some txt file. Every time I forgot where I put the
note or I entirely forgot of the packages installed. Most package managers
does not let you to save a group of packages so I wrote a little 
script that allows you to do it. You can find **pacgroup** in the `\bin` folder. 
If you install the whole repo it's already available in your `$PATH`.
This utility is thinked to be used with the Archlinux package manager **pacman** 
but it's really easy to convert it to be used with other package managers.


To create a new group simply write `pacgroup --create mygroup package1 package2 ...`.
To delete the reference to the group created (installed packages will not be actually removed) the syntax is `pacgroup --delete mygroup`. 
You can also `pacgroup --list` to see all groups saved and `pacgroup --list groupname to see the packages contained in the group.`

To actually install/remove packages you can use the standard `pacman` command line arguments with `pacgroup` (*i.e.* `pacgroup -Sy mygroup`).
The group name will be expanded and all arguments passed to `pacman`.

Use this utility without `sudo`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## disclaimer

These are my personalized dotfiles and will not work on every system. To avoid problems copy the folder/file of interest and browse the source code deleting everything you don't understand. This is a good practice. 

## thanks

I forked [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and modified for my needings so all credits go to him.

 
