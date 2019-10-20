# dotfiles
Configuration files and utilities for my development PC.

* OS: debian sid, or ubuntu (latest release)
* Required:
	- vim
	- zsh
	- tmux
	- xclip
	- xinput
	- x11-xserver-utils
	- tig
	- ctags
	- gawk
	- i3

## Installation
```
git clone --recurse-submodules github.com:yuuki0xff/dotfiles ~/.dotfiles
ln -si ~/.dotfiles/files/{.,}* ~
chsh -s $(which zsh)

sudo apt install python3-pip
pip3 install --user -r .i3/rerequirements.txt

rsync -a ~/.dotfiles/user-config/ ~/.config/
```

