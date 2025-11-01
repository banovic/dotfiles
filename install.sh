#!/bin/sh
# Install script for dotfiles

# Dotfiles dir is where this script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Make symlinks:
touch ~/.secrets
ln -sf "${DOTFILES_DIR}/profile" ~/.profile
ln -sf "${DOTFILES_DIR}/bashrc" ~/.bashrc
ln -sf "${DOTFILES_DIR}/Xmodmap" ~/.Xmodmap