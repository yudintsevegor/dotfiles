# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
#export GO111MODULE=auto
export GO111MODULE=off
#GOROOT=$HOME/go
#PATH=$PATH:$GOROOT/bin

#: << 'END'

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

# Color definitions
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BROWN='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
LIGHTGREY='\[\033[0;37m\]'
LIGHTRED='\[\033[1;31m\]'
LIGHTGREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LIGHTBLUE='\[\033[1;34m\]'
LIGHTPURPLE='\[\033[1;35m\]'
LIGHTCYAN='\[\033[1;36m\]'
DARKGREY='\[\033[1;37m\]'
NORMAL='\[\033[00m\]'

# Git branch in prompt.
git_branch() {
	#source ~/.git-prompt.sh
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Find dirty state
function parse_git_dirty {
  [[ -n "$(git status -s 2> /dev/null)" ]]
}

PS1="${YELLOW}\d ${CYAN}\t ${LIGHTRED}jobs:\j ${LIGHTGREEN}\u@\h${PURPLE}\$(git_branch)\$(parse_git_dirty)${NORMAL}:${LIGHTBLUE}\w${NORMAL}\$ \n>>> "


: << 'END'
if [ "$color_prompt" = yes ]; then
	PS1="${YELLOW}\t ${LIGHTRED}joobs:\j${NORMAL} ${LIGHTGREN}\u@\h $(git_branch) ${NORMAL}:${LIGHTBLUE}\w${NORMAL}\$ \n>>> "
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
END
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x ~/.dircolors ]; then
	eval $(gdircolors -b ~/.dircolors/dircolors.256dark)	
	#test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors/dircolors.256dark)"# || eval "$(dircolors -b)"
	alias ls='gls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	#alias fgrep='fgrep --color=auto'
	#alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#some cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
#alias cdtest = 'cd ~/work/test_task/'
#Git aliases
alias gfeces='git commit -m "Code style fixes"'
alias gst='git status'
alias gadd='git add'
alias giff='git diff'
alias gpom='git push origin master'
alias glog='git log'

#Other aliases
alias hist='history'
alias f='find'
alias cl='clear'
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias histg="history | grep -v grep | grep"
alias myip="curl http://ipecho.net/plain; echo"
alias fresh=". ~/.profile"

#alias mac
alias cdsupD='cd ~/go/src/hotcore2go-apps.ostrovok.in/supplierd'
alias cdsupC='cd ~/go/src/hotcore2go-apps.ostrovok.in/supplier-content'
alias cdbook='cd ~/go/src/hotcore2go-apps.ostrovok.in/go-booker'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

#to rename tab in terminal

function set-title() {
	if [[ -z "$ORIG" ]]; then
		ORIG=$PS1
	fi
	TITLE="\[\e]2;$*\a\]"
	PS1=${ORIG}${TITLE}
}

export LANG=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_NAME=en_US.UTF-8


