SHELL = bash

PREFIX ?= $(HOME)
# Expected value: Linux or Darwin
KERNEL ?= $(shell uname)
# Expected value: linux or mac
ifeq ($(KERNEL),Linux)
	OS ?= linux
endif
ifeq ($(KERNEL),Darwin)
	OS ?= mac
endif
DOT_FILES_DIR ?= ~/.dotfiles
# Expected value: non-zero or zero
ifeq ($(OS),linux)
ifneq ($(DISPLAY),)
	# Detected the linux desktop environment.
	LINUX_DESKTOP ?= 1
endif
endif
LINUX_DESKTOP ?= 0

# BIN_TMPLS := $(wildcard files/bin/*.tmpl)
# BIN_FILES := $(filter-out $(BIN_TMPLS),$(wildcard files/bin/*))
ROOT_FILES := $(filter-out files/. files/..,$(wildcard files/* files/.*))
ABS_ROOT_FILES := $(foreach i,$(ROOT_FILES),$(DOT_FILES_DIR)/$(i))
OLD_LINKS := .vimperatorrc
ABS_OLD_LINKS := $(foreach i,$(OLD_LINKS),$(PREFIX)/$(i))

format:
	echo files/.* files/* |xargs -n1 |grep -ve '/\.$$' -e '/\.\.$$' >install-targets/all.txt
	./tools/format-file-list install-targets/all.txt
	./tools/format-file-list install-targets/linux.txt
	./tools/format-file-list install-targets/mac.txt
	diff -u install-targets/all.txt <(sort -u install-targets/linux.txt install-targets/mac.txt)

install:
	$(MAKE) checkout-submodules
	rm -f $(ABS_OLD_LINKS)
	install -d $(PREFIX)
	./tools/install-links install-targets/$(OS).txt $(DOT_FILES_DIR) $(PREFIX)/
ifeq ($(OS),linux)
	PREFIX=./files/ ./tools/generate-firefox-helper
endif
ifeq ($(OS),mac)
	# TODO: macでは複数のプロファイルを使用していないため、firefox helperは使わない。。
endif
ifneq ($(LINUX_DESKTOP),0)
	# For linux desktop.
	pipx uninstall i3-wm-config || :  # This process may fail. Ignore it.
	pipx install files/.i3/helper/
	make -C files/.i3/ build
endif
ifeq ($(OS),linux)
	# For linux.
	rsync -a ~/.dotfiles/user-config/ ~/.config/
endif
	# Replace the ~/.dotfiles symlink.
	ls -lhd ~/.dotfiles || :
	ln -snf $(shell pwd) ~/.dotfiles
ifneq ($(LINUX_DESKTOP),0)
	# Reload desktop environment.
	i3-msg reload
endif
	# Installation completed. You should restart the terminal or the desktop environment.
	#
	# If you want to rollback, please execute the following command.
	#
	#   cd ~/.dotfiles.$OLD_REVISION
	#   make install

test:
ifeq ($(KERNEL),Linux)
	if update-alternatives --get-selections |grep -q '^x-terminal-emulator '; then \
		update-alternatives --get-selections |grep '^x-terminal-emulator ' |grep ' /usr/bin/xterm$$'; \
	fi

	# homeにインストールしたやつを使っているので、当面はこの設定は無視。
	# update-alternatives --get-selections |grep '^x-www-browser '
	# update-alternatives --get-selections |grep '^x-www-browser ' |grep firefox

	update-alternatives --get-selections |grep -q '^awk '
	update-alternatives --get-selections |grep '^awk ' |grep ' /usr/bin/gawk$$'
endif

checkout-submodules:
	git submodule init
	git submodule update --recursive --checkout --jobs 16

update-submodules:
	git submodule init
	git submodule update --recursive --remote --checkout --jobs 16
