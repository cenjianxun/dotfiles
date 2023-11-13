#----------------------------------------------------------------------
# Initialize environment and alias
#----------------------------------------------------------------------
export LANGUAGE=en_US # :zh_CN

case "$OSTYPE" in
	*gnu*|*linux*|*msys*|*cygwin*) alias ls='ls --color' ;;
	*freebsd*|*darwin*) alias ls='ls -G' ;;
esac

alias ll='ls -lh'
alias grep='grep --color=tty'

# default editor
#export EDITOR=vim

# 颜色
export CLICOLOR=1
export LSCOLORS=exFxcxdxexdacaecCcxfaf
#export TERM=xterm-256color

# history
HISTSIZE=2000
HISTFILESIZE=5000

# python 软链
alias python="/opt/homebrew/bin/python3.10"
alias pip="/opt/homebrew/bin/pip3.10"

# Go
export GOROOT="$(brew --prefix golang)/libexec"  # go的安装环境，由brew决定
export GOPATH=$HOME/work/Go   # go的运行环境，工作地点，新建个
if [[ ":${PATH}:" != *"${GOROOT}/bin"* ]]; then
	export PATH="$PATH:${GOROOT}/bin"
fi
if [[ ":${PATH}:" != *"${GOPATH}/bin"* ]]; then
	export PATH="$PATH:${GOPATH}/bin"
fi
