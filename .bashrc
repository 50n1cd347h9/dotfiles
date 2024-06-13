#
# ~/.bashrc
#

[[ $- != *i* ]] && return

export HISTSIZE=2000
export HISTFILESIZE=2000
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$HOME/.pyenv/bin:$PATH
export PATH="$HOME/zig-linux-x86_64-0.13.0-dev.46+3648d7df1:$PATH"
export PATH="$HOME/local/llvm17-release/bin:$PATH"
export PATH="/opt:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx



[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='history -a;history -n;echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true



safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""

# [[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
# [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
# [[ -z ${match_lhs}    ]] \
# 	&& type -P dircolors >/dev/null \
# 	&& match_lhs=$(dircolors --print-database)
# 	[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1="\[$(tput bold)\]\[\033[01;31m\][\h\[$(tput sgr0)\] \[\033[01;36m\]\W\[$(tput sgr0)\]\[\033[01;31m\]]\$ \[$(tput sgr0)\]"
	elif [[ $(ps aux | grep "sshd" | grep -v "root" | grep -v "grep") ]]; then
	 	PS1="\[$(tput bold)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\] \[$(tput bold)\]\[\033[38;5;11m\]\W\[$(tput sgr0)\] \[$(tput bold)\]\[\033[38;5;13m\]ssh $ \[$(tput sgr0)\]"
	else
		PS1="\[$(tput bold)\]\[\033[38;5;2m\]\u\[$(tput sgr0)\] \[$(tput bold)\]\[\033[38;5;11m\]\W\[$(tput sgr0)\] \[$(tput bold)\]\[\033[38;5;13m\]🍣 \[$(tput sgr0)\]"
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi


unset use_color safe_term match_lhs sh

alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias python="python3"

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

shopt -s histappend
shopt -s cmdhist
export HISTCONTROL=ignoreboth:erasedups

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1     ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Colorized man using less
man() {
	LESS_TERMCAP_md=$'\e[01;31m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[01;44;33m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[01;32m' \
		command man "$@"
	}


# Theme.sh
export THEME_HISTFILE=~/.theme_history
[ -e "$THEME_HISTFILE" ] && theme.sh "$(theme.sh -l|tail -n1)"
alias th='theme.sh -i2'

ROOT_TERMINAL_THEME="red-alert"
SSH_TERMINAL_THEME="mellow-purple"

su() {
	(
	INHIBIT_THEME_HIST=1 theme.sh ${ROOT_TERMINAL_THEME}
	trap 'theme.sh "$(theme.sh -l|tail -n1)"' INT
	env su "$@"
	theme.sh "$(theme.sh -l|tail -n1)"
)
}

# Git prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
	GIT_PROMPT_ONLY_IN_REPO=1
	source $HOME/.bash-git-prompt/gitprompt.sh
fi

# Fuzzy Finder (fzf)
if [[ -e /usr/share/fzf ]]; then
	source /usr/share/fzf/completion.bash
	source /usr/share/fzf/key-bindings.bash
fi


# NVM
if [[ -e $HOME/.nvm ]]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


# RVM (ruby)
if [[ -e $HOME/.rvm ]]; then
	export PATH="$PATH:$HOME/.rvm/bin"
	source $HOME/.rvm/environments/ruby-3.1.2
fi


arch=`uname -m`
if [ "$arch" = "x86_64" ]; then
	PATH=$PATH:/usr/local/bin
else
	PATH=/opt/homebrew/bin:$PATH
	PATH="/opt/homebrew/sbin:$PATH"
	# eval "$(nodenv init -)" などはどちらかインストールした方に書く
fi



if command -v nvim &>/dev/null; then
	alias vi='nvim'
	alias vim='nvim'
fi


if command -v ccat &>/dev/null; then
	alias cat='ccat'
fi

if command -v git &>/dev/null; then
	alias tree='git log --oneline --graph --color --all --decorate'
fi

# bun

export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=/opt/riscv/bin:$PATH
export PATH=/opt/binaryninja:$PATH
alias binja="binaryninja &"

if command -v tmux &>/dev/null; then
	count=`ps aux | grep tmux | grep -v grep | wc -l`
	if test $count -eq 0; then
		echo `tmux new-session`
	elif test $count -eq 1; then
		echo `tmux a`
	fi	
fi


# below line is needed if you use gdb with gef
export LC_CTYPE=C.UTF-8
. "$HOME/.cargo/env"


if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

