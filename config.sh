# echo "set config.sh .."
#----------------------------------------------------------------------
# Initialize environment and alias
#----------------------------------------------------------------------

#---------------------------------------
# public config
#---------------------------------------
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


#----------------------------------------
# install & alias
#----------------------------------------

if [[ `uname` == "Darwin" ]]; then
	#check="brew list"
	download="brew"
else
	#check="rpm -qa"
	download="yum"
fi
# 本来检查是否安装命令是 $check ｜ grep -qw python3, 不如下面这个通用，改了。

# python
if ! command -v python3 &>/dev/null; then
	printf "%s" "python3 is not installed. Do you want to install it? (y/n)"
	read choice
	case "$choice" in
		y|Y )
			$download install python #&
			#wait $!
			echo "python version $(python --version) is already installed."
			;;
		#* ) echo "python installation skipped.";;
	esac
fi

if command -v python3 &>/dev/null; then
	alias python=python3
	alias pip=pip3
fi
#alias python="/opt/homebrew/bin/python3.10"
#alias pip="/opt/homebrew/bin/pip3.10"

# Go
if ! command -v go &>/dev/null; then
	printf "%s" "Golang is not installed. Do you want to install it? (y/n)"
	read choice
	case "$choice" in
		y|Y )
			$download install go #&
			# wait $!
			echo "$(go version) is already installed."
			;;
		#* ) echo "Golang installation skipped.";;
	esac
fi

if command -v go &>/dev/null; then
	export GOROOT="$(brew --prefix golang)/libexec"  # go的安装环境，由brew决定
	[ ! -d "$HOME/work/Go" ] && mkdir "$HOME/work/Go"
	export GOPATH=$HOME/work/Go   # go的运行环境，工作地点，新建个
	if [[ ":${PATH}:" != *"${GOROOT}/bin"* ]]; then
		export PATH="$PATH:${GOROOT}/bin"
	fi
	if [[ ":${PATH}:" != *"${GOPATH}/bin"* ]]; then
		export PATH="$PATH:${GOPATH}/bin"
	fi
fi
