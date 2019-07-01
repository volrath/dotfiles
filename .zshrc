ZSH=$HOME/.oh-my-zsh

AUTO_PARAM_SLASH='true'
CASE_SENSITIVE='true'
DISABLE_AUTO_TITLE='true'
DISABLE_AUTO_UPDATE=true

plugins=(
    archlinux command-not-found colored-man-pages colorize debian
    django docker docker-compose history-substring-search git
    git-extras jump pass python pj virtualenv supervisor systemadmin
    tmux tmuxinator

)

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
  return
fi

# General Configuration
# ------------------------------------------------------------------------------

bindkey -e

export HISTFILE=~/.long_history
export HISTFILESIZE=50000
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT='%h/%d - %H:%M:%S'

setopt HIST_FCNTL_LOCK
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS
setopt NO_SHARE_HISTORY
unsetopt correct_all

bindkey '\e[5~' history-substring-search-up
bindkey '\e[6~' history-substring-search-down
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

PROJECT_PATHS=(~/projects ~/projects/oss)

source $ZSH/oh-my-zsh.sh

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit


# Theme
# ------------------------------------------------------------------------------

prompt_virtualenv() {  # Virtualenv: current working virtualenv
    local virtualenv_path=${VIRTUAL_ENV}
    if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        echo -n " (`basename $virtualenv_path`)"
    fi
}

if [ $HOST = garuda ] || [ $HOST = antares ]; then
    PROMPT='%F{blue}[%F{cyan}%M%F{blue}]%F{yellow}$(prompt_virtualenv) %F{green}%2c%F{blue} [%f '
else
    PROMPT='%B%F{red}[%n@%M]%b%F{yellow}$(prompt_virtualenv) %F{green}%2c%F{blue} [%f '
fi
RPROMPT='$(git_prompt_info) %F{blue}] %F{green}%T %F{yellow}>%f'

ZSH_THEME_GIT_PROMPT_PREFIX='%F{yellow}'
ZSH_THEME_GIT_PROMPT_SUFFIX='%f'
ZSH_THEME_GIT_PROMPT_DIRTY=' %F{red}*%f'
ZSH_THEME_GIT_PROMPT_CLEAN=''


# Aliases
# ------------------------------------------------------------------------------

alias pubkey="more ~/.ssh/id_rsa.pub | xclip -i | echo '=> Public key copied to pasteboard.'"
alias serve='python3 -m http.server'
alias top=htop
alias duf='du -sh *'
alias psf='ps -aux | grep'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias reload!='. ~/.zshrc'

# Environment & Path
# ------------------------------------------------------------------------------

[ -f "$HOME/.profile" ] && source ~/.profile


# Random Tools
#-------------------------------------------------------------------------------

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh


# Local Configuration
# ------------------------------------------------------------------------------
# Use `~/.localrc` for anything that's particular to this installation.

if [[ -a ~/.localrc ]]
then
    source ~/.localrc
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
