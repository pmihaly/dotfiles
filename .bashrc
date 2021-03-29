#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export BROWSER='/usr/bin/brave'
export TERM=st-256color

export PATH=~/.local/bin:$PATH

# PS1='[\u@\h \W]\$ '
export PS1="[\[\e[31;40m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\] \W]\\$ "
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set -o vi
bind -m vi-insert "\C-l":clear-screen

export HISTFILESIZE=0
export HISTSIZE=100
export HISTSIZE='~/.config/history'


[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "$HOME/.cache/wal/colors.sh" ] && source "$HOME/.cache/wal/colors.sh"


grff() { preconv "$1" | groff -ms - -Kutf8 -Tpdf > "${1%%.ms}.pdf"; }

