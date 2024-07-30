#第一行不能加shebang，因为此脚本内容需要判断当前环境
startTime_s=`date +%s`
echo "start bootstrap.sh ..."

# 此脚本文件的绝对路径
DOTFILE=$(readlink -f $0)
# 此脚本文件所在文件夹的绝对路径
DOTDIR=$(dirname $DOTFILE)
# 注意：这两行要分开写，不要合并成一句，否则变量内容为空。
echo "DOTDIR 路径：$DOTDIR"

# 不知道为什么if [ -n "$BASH_VERSION" ]不行，它和$ZSH_VERSION都为空。因此使用其他方式判断
# 另外这里改一下判断条件，注意“本机安装了zsh”和“当前环境为zsh”是不同的。这里改用“本机安装”当条件吧
if  which bash >/dev/null; then
	if [ ! -e "$HOME/.bashrc" ] || ! grep -q "init.sh" "$HOME/.bashrc"; then
        echo "DOTDIR=$DOTDIR" >> $HOME/.bashrc
		# 注意echo只执行了写入，并没有执行source
		echo 'source $DOTDIR/init.sh' >> $HOME/.bashrc
    fi
fi

#echo $ZSH_VERSION

#if [ -n "$ZSH_VERSION" ]; then
if which zsh >/dev/null; then
	if [ ! -e "$HOME/.zshrc" ] || ! grep -q "init.sh" "$HOME/.zshrc"; then
		echo "DOTDIR=$DOTDIR" >> $HOME/.zshrc
		echo 'source $DOTDIR/init.sh' >> $HOME/.zshrc 
    fi
fi

# vim
if [ ! -e "$HOME/.vimrc" ] || ! grep -q "init.vim" "$HOME/.vimrc"; then
	echo 'let g:bundle_group = ["simple"]' >> ~/.vimrc
	echo 'so '$DOTDIR'/init.vim' >> ~/.vimrc
fi

# git
if [ ! -e "$HOME/.gitconfig" ]; then
	echo "install git ..."
	# todo 要可选吗？分系统类型
	brew install git
fi

if ! grep -qFf gitconfig $HOME/.gitconfig; then
	cat gitconfig >> $HOME/.gitconfig
fi

"$DOTDIR/init.sh"