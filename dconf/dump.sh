#!/bin/bash
set -eux
dconf dump /org/gnome/terminal/ >dconf/gnome-terminal.dconf
