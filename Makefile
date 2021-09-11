PREFIX ?= $(HOME)
# Expected value: Linux or Darwin
KERNEL ?= $(shell uname)
DOT_FILES_DIR ?= ~/.dotfiles

# BIN_TMPLS := $(wildcard files/bin/*.tmpl)
# BIN_FILES := $(filter-out $(BIN_TMPLS),$(wildcard files/bin/*))
ROOT_FILES := $(filter-out files/. files/..,$(wildcard files/* files/.*))
ABS_ROOT_FILES := $(foreach i,$(ROOT_FILES),$(DOT_FILES_DIR)/$(i))
OLD_LINKS := .vimperatorrc
ABS_OLD_LINKS := $(foreach i,$(OLD_LINKS),$(PREFIX)/$(i))

install:
	rm -f $(ABS_OLD_LINKS)
	install -d $(PREFIX)
	ln -si $(ABS_ROOT_FILES) $(PREFIX)/
ifeq ($(KERNEL),Linux)
	PREFIX=./files/ ./tools/generate-firefox-helper
endif
ifeq ($(KERNEL),Darwin)
	# TODO: macでは複数のプロファイルを使用していないため、firefox helperは使わない。。
endif

checkout-submodules:
	git submodule update --recursive --checkout

update-submodules:
	git submodule update --recursive --remote --checkout
