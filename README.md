# my dotfiles

## dotfiles

These are my dotfiles. I started to store them here to have a backup for me and maybe to offer a source of inspiration for others. These dotfiles are meant to be portable, to an acceptable extent.

The organization of these dotfiles is managed using `stow`. Every folder is a package for the configurations of a single software, by `stow`ing it the files inside the folder will get symlinked to the correct position inside your `$HOME`. Learn how `stow` works before using these dotfiles (it's really simple).

To *use* this, you have to fork/copy/download/steal these dotfiles and personalize them for your system(s).

## install

Before installing you need to be sure that the new dotfiles will not broke your system configuration. In particular you need to pay attention to
things like shell and wm configurations which contain directives specific to the desktop environment and shell that I use (bspwm and zsh).

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

If you like something in this repo, [fork it](https://github.com/Nadorrano/dotfiles/fork), remove what you don't use, and build on what you do use.


## disclaimer

These are my personalized dotfiles and will not work on every system. To avoid problems copy `stow` only the folders of interest and browse the source code deleting everything you don't need.

## thanks

I originally forked [Zach Holman's dotfiles](https://github.com/holman/dotfiles) and added my code as well as snippets taken from the internet, thanks to everyone.
Most of the work is original content though I probably miss to credit large part of stolen code, if you recognize your code conctact me and you will be credited.

