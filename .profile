#!/bin/sh

export LANG='en_US.UTF-8'
export TERM='screen-256color'
export TERMINAL='st'
export EMAIL='Daniel Barreto <daniel@barreto.tech>'
export EDITOR='emacsclient -nw'
export FCEDIT='emacsclient -nw'
export VISUAL='emacsclient -c'
export BROWSER='firefox-nightly'
export DJANGO_COLORS='dark'
export PROJECT_HOME=${HOME}/projects


export ANDROID_HOME=${HOME}/.local/share/Android/SDK
export PATH=${PATH}:${HOME}/.cask/bin
export PATH=${PATH}:${HOME}/.rvm/bin
export PATH=${PATH}:${HOME}/.npm-global/bin
export PATH=${PATH}:${HOME}/.local/bin
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools


if [ -d "$HOME/.scripts" ]; then
    export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
    export PATH="$(du $HOME/.scripts/ | cut -f2 | tr '\n' ':')$PATH"
fi
