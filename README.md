# my dotfiles

## dotfiles

These are my dotfiles. I started to store them here to have a backup for me and maybe to offer a source of inspiration for others. These dotfiles are meant to be compatible with various linux systems with little modifications.

I originally forked this repo from [Zach Holman one](https://github.com/holman/dotfiles).

To *use* this, you have to fork/copy/download/steal these dotfiles and personalize them for your system(s).

## install

Before installing you need to be sure that the new dotfiles will not broke your system configuration. In particular you need to pay attention to
things like shells and Xorg which contains directives specific to the desktop environment that I use (xfce).

To install these .dotfiles run this:

```sh
git clone https://github.com/Nadorrano/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```

Then symlink the appropriate files in `.dotfiles` to your home directory. The process can be automated with programs like `stow`.
Everything is configured and tweaked within `~/.dotfiles`.

## what's inside

If you like something in this repo,
[fork it](https://github.com/Nadorrano/dotfiles/fork),
remove what you don't use, and build on what you do use.


## disclaimer

These are my personalized dotfiles and will not work on every system. To avoid problems copy the folder/file of interest and browse the source code deleting everything you don't understand. This is a good practice.

## thanks

I originally forked [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and also added snippets taken from the internet, thanks to everyone.

