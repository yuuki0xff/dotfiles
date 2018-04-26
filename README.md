# dotfiles
Configuration files and utilities for my development PC.

* OS: debian sid, or ubuntu (latest release)
* Required:
	- vim
	- zsh
	- tmux
	- xclip
	- x11-xserver-utils
	- tig
	- ctags
	- gawk
	- i3

## installation
```
git clone --recurse-submodules github.com:yuuki0xff/dotfiles ~/.dotfiles
ln -si ~/.dotfiles/files/{.,}* ~
ln -si ~/.gitconfig.$(hostname) ~/.gitconfig
chsh -s $(which zsh)
```

