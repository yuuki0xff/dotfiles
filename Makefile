SHELL = bash

PREFIX ?= $(HOME)
DOT_FILES_DIR ?= ~/.dotfiles

# Variable: KERNEL
# Expected value: Linux or Darwin
KERNEL ?= $(shell uname)

# Variable: OS
# Expected value: linux or mac
ifeq ($(KERNEL),Linux)
	OS ?= linux
endif
ifeq ($(KERNEL),Darwin)
	OS ?= mac
endif

# Variable: I3_DESKTOP
# Expected value: non-zero or zero
ifeq ($(OS),linux)
ifneq ($(DISPLAY),)
ifneq ($(shell which i3),)
	# Detected the i3 desktop environment.
	I3_DESKTOP ?= 1
endif
endif
endif
I3_DESKTOP ?= 0

# Variable: SWAY_DESKTOP
# Expected value: non-zero or zero
ifeq ($(OS),linux)
ifneq ($(DISPLAY),)
ifneq ($(shell which sway),)
	# Detected the sway desktop environment.
	SWAY_DESKTOP ?= 1
endif
endif
endif
SWAY_DESKTOP ?= 0

# BIN_TMPLS := $(wildcard files/bin/*.tmpl)
# BIN_FILES := $(filter-out $(BIN_TMPLS),$(wildcard files/bin/*))
ROOT_FILES := $(filter-out files/. files/..,$(wildcard files/* files/.*))
ABS_ROOT_FILES := $(foreach i,$(ROOT_FILES),$(DOT_FILES_DIR)/$(i))
OLD_LINKS := .vimperatorrc
ABS_OLD_LINKS := $(foreach i,$(OLD_LINKS),$(PREFIX)/$(i))

.PHONY: format
format:
	echo files/.* files/* |xargs -n1 |grep -ve '/\.$$' -e '/\.\.$$' >install-targets/all.txt
	./tools/format-file-list install-targets/all.txt
	./tools/format-file-list install-targets/linux.txt
	./tools/format-file-list install-targets/mac.txt
	diff -u install-targets/all.txt <(sort -u install-targets/linux.txt install-targets/mac.txt)

.PHONY: install
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
ifneq ($(I3_DESKTOP)$(SWAY_DESKTOP),00)
	# For linux i3 desktop environment.
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
ifneq ($(I3_DESKTOP),0)
	# Reload i3 desktop environment.
	i3-msg reload
endif
ifneq ($(SWAY_DESKTOP),0)
	# Reload sway desktop environment.
	swaymsg reload
endif
	# Installation completed. You should restart the terminal or the desktop environment.
	#
	# If you want to rollback, please execute the following command.
	#
	#   cd ~/.dotfiles.$$OLD_REVISION
	#   make install

.PHONY: test
test:
	$(info ===== Variables =====)
	$(info SHELL=$(SHELL))
	$(info PREFIX=$(PREFIX))
	$(info DOT_FILES_DIR=$(DOT_FILES_DIR))
	$(info KERNEL=$(KERNEL))
	$(info OS=$(OS))
	$(info DISPLAY=$(DISPLAY))
	$(info I3_DESKTOP=$(I3_DESKTOP))
	$(info SWAY_DESKTOP=$(SWAY_DESKTOP))
	$(info ROOT_FILES=$(ROOT_FILES))
	$(info ABS_ROOT_FILES=$(ABS_ROOT_FILES))
	$(info OLD_LINKS=$(OLD_LINKS))
	$(info ABS_OLD_LINKS=$(ABS_OLD_LINKS))
	$(info =====================)

ifeq ($(KERNEL),Linux)
	# Check alternatives.
	if update-alternatives --get-selections |grep -q '^x-terminal-emulator '; then \
		update-alternatives --get-selections |grep '^x-terminal-emulator ' |grep ' /usr/bin/xterm$$'; \
	fi

	# homeにインストールしたやつを使っているので、当面はこの設定は無視。
	# update-alternatives --get-selections |grep '^x-www-browser '
	# update-alternatives --get-selections |grep '^x-www-browser ' |grep firefox

	update-alternatives --get-selections |grep -q '^awk '
	update-alternatives --get-selections |grep '^awk ' |grep ' /usr/bin/gawk$$'
endif

.PHONY: checkout-submodules
checkout-submodules:
	git submodule init
	git submodule update --recursive --checkout --jobs 16

.PHONY: update-submodules
update-submodules:
	git submodule init
	git submodule update --recursive --remote --checkout --jobs 16
