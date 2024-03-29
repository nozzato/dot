#!/bin/zsh

export PATH="$PATH":~/bin:~/.local/bin
export EDITOR=nvim

# clipmenu
export CM_IGNORE_WINDOW=KeePassXC
export CM_SELECTIONS=clipboard

# Go
export GOPATH=$HOME/.go

# GTK
export GTK_THEME=Adwaita:dark

# OpenAL
export ALSOFT_DRIVERS=pulse

# ranger
export RANGER_LOAD_DEFAULT_RC=0

# SSH
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# Sudo
export SUDO_ASKPASS=~/bin/dpass

# VeraCrypt
export WXSUPPRESS_SIZER_FLAGS_CHECK=1

# Zsh
export ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;&'
