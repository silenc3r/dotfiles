## Profiling START
# exec 3>&2 2> >(tee /tmp/sample-time.$$.log |
#                  sed -u 's/^.*$/now/' |
#                  date -f - +%s.%N >/tmp/sample-time.$$.tim)
# set -x

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [[ ! "$PATH" == *$HOME/.local/share/npm/bin* ]]; then
    PATH="$HOME/.local/share/npm/bin:$PATH"
fi
if [[ ! "$PATH" == *$HOME/.local/bin* ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [[ ! "$PATH" == *$HOME/bin* ]]; then
    PATH="$HOME/bin:$PATH"
fi

export PATH

# update LS_COLORS to use terminal colorscheme
eval "$(dircolors)"

# prevent terminal from overwriting Ctrl-s shortcut
stty -ixon

# update window size after every command
shopt -s checkwinsize
# prevent file overwrite on stdout redirection
# use `>|` to force redirection to an existing file
set -o noclobber

# enable extended globbing
shopt -s extglob
# turn on recursive globbing (enables ** to recurse all directories)
# this causes some issuses with fzf complete
# shopt -s globstar
# case-insensitive globbig (used in pathname expansion)
shopt -s nocaseglob
# cd when entering just a path
shopt -s autocd
# correnct minor errors in the spelling of directories
shopt -s cdspell
# correct directory names and expand vars during tab-completion
shopt -s dirspell
# shopt -s direxpand

# verify commands via history expansions
shopt -s histverify
# append to the history file, don't overwrite it
# this isn't needed if we have `history -a` in prompt command
shopt -s histappend
# store multiline commands as one command
shopt -s cmdhist

HISTSIZE=10000
HISTFILESIZE=1000000
if [ -n "$XDG_DATA_HOME" ]; then
    export HISTFILE="$XDG_DATA_HOME/bash/history"
fi
# unset HISTFILE
HISTIGNORE="?:??:[ ]*:history:clear:z *:j *:b *:"
# ingore duplicates and commands starting with spacebar
HISTCONTROL=ignoreboth
# Add a timestamp to each history entry.
HISTTIMEFORMAT='%F %T  '

# limit per-process memory usage to 8 GB
ulimit -Sv 8388608

if hash fzf 2> /dev/null; then
    if hash fd 2> /dev/null; then
        _fzf_compgen_path() {
            fd --follow . "$1"
        }
        _fzf_compgen_dir() {
            fd --type d --follow . "$1"
        }
    fi

    # cd to selected directory
    d () {
        local dir
        dir=$(fd --type d --follow . "${1:-.}" | fzf +m --reverse --height=40%) && builtin cd "$dir"
    }
    dh () {
        local dir
        dir=$(fd --type d --hidden --follow . "${1:-.}" | fzf +m --reverse --height=40%) && builtin cd "$dir"
    }

    # open file in $VISUAL
    v () {
        local file
        file=$(fd --type f --hidden --follow --exclude ".git" . "${1:-.}" | fzf +m --reverse --height=40%) && "$VISUAL" "$file"
    }

    [ -f /usr/share/fzf/shell/key-bindings.bash ] && \
        source /usr/share/fzf/shell/key-bindings.bash
fi

# zummi
# [ -f "$HOME"/.local/share/zummi/zummi.bash ] \
#     && source "$HOME"/.local/share/zummi/zummi.bash 

# Ranger autocd
[ -f /usr/share/doc/ranger/examples/bash_automatic_cd.sh ] \
    && source /usr/share/doc/ranger/examples/bash_automatic_cd.sh

ccd() { mkdir -p "$*" && cd "$*" || return ; }

psgrep() { ps aux | grep -v grep | grep -i --color=none -e VSZ -e "$@"; }

nohist() { unset HISTFILE; }
hsync() { history -a && history -n; }

# transmission helpers
trl() { transmission-remote -l; }
trd() { transmission-remote -t "$1" --remove-and-delete; }
trr() { transmission-remote -t "$1" --remove; }
tri() { transmission-remote -t "$1" --info; }

# aliases
alias dmesg='dmesg --color'
alias ls='ls --color=auto --group-directories-first'
alias la='ls --almost-all'
alias ll='ls -l --human-readable'
alias lla='ll --almost-all'
alias l1='ls -1'
# list hidden files only
lh() {
    _lh() { ls -d .!(|.) 2> /dev/null || true; }
    if [ -n "$1" ]; then
        (cd "$1" && _lh)
    else
        _lh
    fi
}

alias -- -='cd -'
alias ..='cd ..'  # redundant with autocd
alias ...='cd ../..'

# alias sudo='sudo '  # make aliases work with sudo
alias ping='ping -c 3'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -c -h'
alias ipe='curl ipinfo.io/ip'

# safety features
alias rm='gio trash'
alias ln='ln -i'

alias rmpyc='find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete'

alias cdgit='cd $(git rev-parse --show-toplevel)'

# clear screen for real (does not work in tmux)
alias cls=' echo -ne "\033c"'

alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias tm='tmux attach || tmux new'

# to prevent dnf using separate caches for user and root
alias dnf='dnf --cacheonly'

lns () {
    ln -s "$(realpath "$1")" "$2"
}

export NOTE_DIR="$HOME"/Notes
alias n=notes.sh
ng() {
    rg "$1" "$HOME"/Notes
}

# https://news.ycombinator.com/item?id=24659282
# bashquote() { printf '%q\n' "$(cat)" ; }
bashquote() { printf '%q' "$(cat)" ; }

## Python config
export PYENV_ROOT="$HOME/.local/pyenv"
export PIPENV_SHELL_FANCY=1
alias psh='poetry shell'

## OPAM configuration
export OPAMROOT="$HOME"/.local/opam
if [ -z "$OPAM_SWITCH_PREFIX" ]; then
    test -r "$OPAMROOT"/opam-init/init.sh && \
        . "$OPAMROOT"/opam-init/init.sh &> /dev/null || true
fi
oenv() { eval "$(opam env --switch="$PWD")"; }

# Local completion
if [ -d "$HOME"/.config/bash_completion.d ]; then
    for compfile in "$HOME"/.config/bash_completion.d/*; do
        . "$compfile"
    done
fi


## Prompt
source /usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
# source /etc/bash_completion.d/git-prompt.sh 2>/dev/null
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
PS1_PWD_MAX=35

__set_prompt () {
    # This must be on top
    local EXIT_VALUE="$?"

    local DefaultOnDarkGray="\[\033[39;100m\]"
    local Bold="\[\033[1m\]"
    local Cyan="\[\033[0;36m\]"
    local DarkGray="\[\033[0;37m\]"
    local LightGrayBG="\[\033[0;47m\]"
    local BlackFG="\[\033[30m\]"
    local Default="\[\033[39m\]"
    local Green="\[\033[0;32m\]"
    # local Green="\[\033[38;5;78m\]"
    local Magenta="\[\033[0;35m\]"
    local BoldBlackOnMagenta="\[\033[0;97;45m\]"
    local BoldMagenta="\[\033[1;35m\]"
    # local BoldBlackOnMagenta="\[\033[1;7;35m\]"
    local Red="\[\033[0;31m\]"
    local White="\[\033[0;97m\]"
    local BoldWhite="\[\033[1;97m\]"
    local Yellow="\[\033[0;33m\]"
    local Blue="\[\033[0;34m\]"

    local ResetColor="\[\033[0m\]"

    # local CursorColor=${Bold}
    local CursorColor=${White}

    __pwd_ps1 () {
        local p=${PWD/#$HOME/\~}
        local compact
        local length=${#p}
        while [[ $p != "${p//\/}" ]] && (( length>PS1_PWD_MAX ))
        do
            p=${p#/}
            [[ $p =~ \.?. ]]
            compact=$compact/${BASH_REMATCH[0]}
            p=${p#*/}
            ((length=${#compact}+${#p}))
        done
        echo -n "${compact/\/~/\~}${compact+/}$p"
    }

    __venv_ps1 () {
        local VENV=""
        if [[ -n "$VIRTUAL_ENV" ]]; then
            VENV=$(basename "${VIRTUAL_ENV}")
        fi
        echo -n "${VENV}"
    }

    __format_exit_status () {
        local RETVAL="$1"
        local SIGNAL
        # Suppress STDERR in case RETVAL is not an integer (in such cases, RETVAL
        # is echoed verbatim)
        if [ "${RETVAL}" -gt 128 ] 2>/dev/null; then
            SIGNAL=$(( RETVAL - 128 ))
            kill -l "${SIGNAL}" 2>/dev/null || echo "${RETVAL}"
        else
            echo "${RETVAL}"
        fi
    }

    local VENV=""
    VENV=$(__venv_ps1)

    PS1=""
    PS1="$PS1${DefaultOnDarkGray}[\D{%T}]${ResetColor} "
    if [ "$EXIT_VALUE" -eq 0 ]; then
        PS1="$PS1${Green}✔ ${ResetColor}"
    else
        PS1="$PS1${Red}✘:$(__format_exit_status "$EXIT_VALUE") ${ResetColor}"
    fi
    PS1="$PS1${Yellow}$(__pwd_ps1) ${ResetColor}"
    PS1="$PS1${DarkGray}$(__git_ps1 '(%s)')${ResetColor}"
    if [ -n "$VENV" ]; then
        CursorColor=${Blue}
        # VENV_stripped=$(sed "s,\x1b\[[0-9;]]*[a-zA-Z],,g" <<<"$VENV")
        # local Save="\e[s"
        # local Restore="\e[u"
        # PS1="$PS1${Magenta}${WhiteOnDarkGray}${Save}\e[${COLUMNS}C\e[${#VENV_stripped}D${VENV}${Restore}${ResetColor}"
        # PS1="$PS1${Magenta}${Save}\e[${COLUMNS}C\e[${#VENV_stripped}D${VENV}${Restore}${ResetColor}"
        # PS1+="${BoldBlackOnMagenta}${Save}\e[${COLUMNS}C\e[$((${#VENV} - 1))D${VENV}${Restore}${ResetColor}"
        PS1+=" ${BoldMagenta}${VENV}${ResetColor}"
    fi
    if [ -n "$OPAMSWITCH" ]; then
        CursorColor=${Magenta}
        PS1+=" ${BoldWhite}$(basename "$OPAMSWITCH")${ResetColor}"
    fi
    PS1+='\n'
    [ -n "$RANGER_LEVEL" ] && PS1="$PS1${DarkGray}>Ranger<${ResetColor} "
    PS1="$PS1${CursorColor}➤ ${ResetColor}"
    # PS1="$PS1${CursorColor}➤ ${White}"
    # # reset color to default
    # trap 'echo -ne "\e[0m"' DEBUG
}

__reset_cursor () { [ -n "$VTE_VERSION" ] && printf "\x1b[0 q"; }

orig_prompt="$PROMPT_COMMAND"
PROMPT_COMMAND=''
# PROMPT_COMMAND+='__set_prompt;' # this has to be first
PROMPT_COMMAND+='__reset_cursor;'
PROMPT_COMMAND+="$orig_prompt"

SBP_PATH="$HOME/.local/sbp"
source ${SBP_PATH}/sbp.bash

# zummi
eval "$(zummi init bash)"

# # Profiling END
# set +x
# exec 2>&3 3>&-
