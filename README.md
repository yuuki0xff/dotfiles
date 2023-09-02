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
```bash
git clone --recurse-submodules github.com:yuuki0xff/dotfiles ~/.dotfiles
cd ~/.dotfiles
make install
chsh -s $(which zsh)


# For linux desktop.
sudo apt install python3-pip
pipx install ~/.i3/helper  # or pipx upgrade-all
make -C ~/.i3 build

# For linux.
rsync -a ~/.dotfiles/user-config/ ~/.config/
```

## Setup Mac
```bash
# OS設定:
#   ダークモードon
#   アクセシビティ→視差効果を減らす
#   アクセシビティ→コントラストを上げる
#   アクセシビティ→カラー以外で区別
#
# ターミナル設定:
#   Profile: Pro
#   Use blink cursor
#   Cursor color: Green
#   Window title: without size
#   Scroll buffer: 0 lines
#   Audio bell: off
#   Visual bell: always
#   シェルの終了時: 正常終了した場合は閉じる
#
# Finder設定:
#   全部チェック入れる

brew install slack firefox
# googleとslackにログイン

ssh-keygen
# gitlab/githubに公開鍵を登録

brew tap jakehilborn/jakehilborn && brew install displayplacer
# toolboxをcloneしてきて、ディスプレイ設定を反映

# gnu版のコマンドを用意
brew install grep gawk gzip gnu-tar gnu-sed gnu-time gnu-getopt binutils findutils diffutils coreutils moreutils

brew install zsh
which zsh |sudo tee -a /etc/shells
# dotfilesをインストール
# ターミナルを開き直す

brew install hammerspoon yabai
# Install yabai. See official wiki.

brew install \
	autossh \
	black \
	clang-format \
	cloc \
	cmake \
	ctags \
	ctemplate \
	entr \
	go \
	graphviz \
	htop \
	ipython \
	jq \
	llvm \
	lnav \
	mycli \
	mysql \
	nkf \
	nmap \
	pwgen \
	python-tabulate \
	ranger \
	rename \
	rsync \
	the_silver_searcher \
	tig \
	tmux \
	trash \
	watch \
	wget \
	yapf \
	zstd

# Install casks.
# NOTE: some casks requires manual operation.
brew install \
	clion \
	forticlient-vpn \
	gimp \
	google-chrome \
	google-cloud-sdk \
	intellij-idea \
	libreoffice \
	mysqlworkbench \
	pycharm \
	wireshark \
	zoom

# ターミナルを開き直す
# 主要サーバにSSH公開鍵を配っておく
```
