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
alias kf='bash $DOTDIR/auto-bot/kill_process.sh'
alias runpy='bash $DOTDIR/auto-bot/nohup-tail.sh'

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

# 本来判断软件如果没安装就自动安装，结果不需要安装的地方每次都跳出来问要不要安装。还是全注释掉，没安装就不管，安装了再设置。

if [[ `uname` == "Darwin" ]]; then
	#check="brew list"
	download="brew"
else
	#check="rpm -qa"
	download="yum"
fi

# 本来检查是否安装命令是 $check ｜ grep -qw python3, 不如下面这个通用，改了。

# ————

# python
# if ! command -v python3 &>/dev/null; then
# 	printf "%s" "python3 is not installed. Do you want to install it? (y/n)"
# 	read choice
# 	case "$choice" in
# 		y|Y )
# 			$download install python #&
# 			#wait $!
# 			echo "python version $(python --version) is already installed."
# 			;;
# 		#* ) echo "python installation skipped.";;
# 	esac
# fi

# -w 判断这个path本用户有没有权限。因为lab的server咱没有root权限
if command -v python3 &>/dev/null && [ ! -e /usr/local/bin/python ] && [ -w "/usr/local/bin" ]; then
	# 因为nohup不能识别alias，所以这里只能用ln，将python3的路径给python。且只用运行一次。
	# ln -s $(which python3) /usr/local/bin/python
	# ln -s $(which pip3) /usr/local/bin/pip
	alias python=python3
	alias pip=pip3
fi

#alias python="/opt/homebrew/bin/python3.10"
#alias pip="/opt/homebrew/bin/pip3.10"

# Go
# if ! command -v go &>/dev/null; then
# 	printf "%s" "Golang is not installed. Do you want to install it? (y/n)"
# 	read choice
# 	case "$choice" in
# 		y|Y )
# 			$download install go #&
# 			# wait $!
# 			echo "$(go version) is already installed."
# 			;;
# 		#* ) echo "Golang installation skipped.";;
# 	esac
# fi

if command -v go &>/dev/null; then
	go env -w GO111MODULE=on
	export GOPROXY=https://goproxy.cn,direct
	
	GOROOT=$(go env GOROOT)
	export GOPATH="$(brew --prefix go)"
	export GOBIN="${GOROOT}/bin"

	if [[ ":${PATH}:" != *"${GOBIN}"* ]]; then
		export PATH="$PATH:${GOBIN}"
	fi
	if [[ ":${PATH}:" != *"${GOPATH}/bin"* ]]; then
		export PATH="$PATH:${GOPATH}/bin"
	fi
fi
