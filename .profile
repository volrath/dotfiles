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

export ANDROID_HOME=${HOME}/.android/sdk
export PATH=${PATH}:${HOME}/.cask/bin
export PATH=${PATH}:${HOME}/.local/bin
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/emulator
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
