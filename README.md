# dotfiles
Configuration files and utilities for my development PC.

* OS: debian sid, or ubuntu (latest release)
* Required:
	- vim
	- zsh
	- rsync
	- tmux
	- xclip
	- xinput
	- x11-xserver-utils
	- tig
	- ctags (universal-ctags)
	- gawk
	- i3
	- pip
	- pipx

## Installation
```bash
(
set -v &&
REVISION=$(date -Isec) &&
git clone https://github.com/yuuki0xff/dotfiles ~/.dotfiles.$REVISION \
	--recurse-submodules --shallow-submodules --jobs 16 &&
ln -snf ~/.dotfiles.$REVISION ~/.dotfiles &&
make -C ~/.dotfiles install &&
chsh -s $(which zsh)
)
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
#   再開→ウィンドウを再度開くときにテキストを復元: off
#
# Finder設定:
#   全部チェック入れる

brew install slack firefox
# googleとslackにログイン

ssh-keygen -t ed25519
# gitlab/githubに公開鍵を登録

brew tap jakehilborn/jakehilborn && brew install displayplacer
# toolboxをcloneしてきて、ディスプレイ設定を反映

# gnu版のコマンドを用意
brew install grep gawk gzip gnu-tar gnu-sed gnu-time gnu-getopt binutils findutils diffutils coreutils moreutils

brew install zsh
echo /opt/homebrew/bin/zsh |sudo tee -a /etc/shells
# dotfilesをインストール
# ターミナルを開き直す

brew install hammerspoon
# Install yabai. See official wiki.
# https://github.com/koekeishiya/yabai/wiki

brew install \
	autossh \
	black \
	clang-format \
	cloc \
	cmake \
	ctags \
	ctemplate \
	entr \
	flock \
	go \
	graphviz \
	htop \
	ipython \
	jq \
	llvm \
	lnav \
	mosh \
	mycli \
	mysql \
	nkf \
	nmap \
	pipx \
	pwgen \
	python-tabulate \
	ranger \
	rename \
	ripgrep \
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
	forticlient-vpn \
	gimp \
	google-chrome \
	google-cloud-sdk \
	jetbrains-toolbox \
	libreoffice \
	microsoft-remote-desktop \
	mysqlworkbench \
	wireshark \
	zoom

# ターミナルを開き直す
# JetBrains Toolboxで必要なIDEをインストール
# 主要サーバにSSH公開鍵を配っておく
```
