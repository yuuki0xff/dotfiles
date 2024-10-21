#!/bin/bash
# Install dotfiles to your home directory.
set -eux

: "${SUFFIX:=$(date -Isec)}"
# REVISION is a git branch name, tag name, or commit hash.
: "${REVISION:=master}"
: "${REPOSITORY:=https://github.com/yuuki0xff/dotfiles}"

# Install dotfiles.
git clone "$REPOSITORY" ~/".dotfiles.$SUFFIX" \
    --single-branch --branch "$REVISION" --no-tags --depth 10 --recurse-submodules --shallow-submodules --jobs 16
ln -snf ~/".dotfiles.$SUFFIX" ~/.dotfiles
make -C ~/.dotfiles install

# chsh to zsh if needed.
case "$SHELL" in
    */zsh)
        ;;
    *)
        chsh -s "$(which zsh)"
        ;;
esac
