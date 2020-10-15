#!/usr/bin/env bash

# CREDITS: This script is based on Zach Holman's work
# (https://github.com/holman/dotfiles/blob/master/script/bootstrap), with some
# minor modifications

set -euo pipefail

if [ "${1+x}" == "-O" ]; then
    overwrite_all=false;
else
    overwrite_all=true;
fi

function info () {
    printf "  [ \033[00;34m..\033[0m ] $1\n"
}

function user () {
    printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

function success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}


function link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $(basename "$src"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "Removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "Moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "Skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "Linked $1 to $2"
  fi
}


function link_dotfiles () {
  info 'Installing dotfiles'

  local backup_all=false skip_all=false

  dotfiles=$(find `pwd` -maxdepth 1 -name '.*' -not -name '.git')
  for src in $dotfiles; do
      if [ "$src" != $(pwd) ]; then
          dst="$HOME/$(basename "${src}")"
          link_file "$src" "$dst"
      fi
  done
}


# Mostly to be used in computers where I don't need (or want) to install my own
# `.emacs.d` configuration.
function install_prelude() {
    if [ ! -d "${HOME}/.emacs.d" ]; then
        wget --no-check-certificate https://github.com/bbatsov/prelude/raw/master/utils/installer.sh -O - | sh;
    fi
}

function install_oh_my_zsh() {
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        curl -L http://install.ohmyz.sh | sh
    fi
}

function install_clojure_jet() {
    if [ ! -d "${HOME}/.local/bin" ]; then
        mkdir -p "${HOME}/.local/bin"
    fi
    bash <(curl -s https://raw.githubusercontent.com/borkdude/jet/master/install) ${HOME}/.local/bin
}


install_prelude
install_oh_my_zsh
install_clojure_jet
link_dotfiles

echo ''
info '=> All installed!'
