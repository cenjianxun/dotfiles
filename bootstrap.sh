# 此脚本文件的绝对路径
SCRIPT=$(readlink -f $0)
# 此脚本文件所在文件夹的绝对路径
SCRIPTPATH=$(dirname $SCRIPT)
# 注意：这两行要分开写，不要合并成一句，否则变量内容为空。
#echo $SCRIPTPATH

if [ -n "$BASH_VERSION" ]; then
    if [ ! -e "$HOME/.bashrc" ] || ! grep -q "init.sh" "$HOME/.bashrc"; then
        echo "DOTDIR=$SCRIPTPATH" >> $HOME/.bashrc
		echo 'source $DOTDIR/init.sh' >> $HOME/.bashrc
    fi
fi

if [ -n "$ZSH_VERSION" ]; then
    if [ ! -e "$HOME/.zshrc" ] || ! grep -q "init.sh" "$HOME/.zshrc"; then
		echo "DOTDIR=$SCRIPTPATH" >> $HOME/.zshrc
		echo 'source $DOTDIR/init.sh' >> $HOME/.zshrc
    fi
fi

if [ ! -e "$HOME/.vimrc" ] || ! grep -q "init.vim" "$HOME/.vimrc"; then
	echo 'let g:bundle_group = ["simple"]' >> ~/.vimrc
	echo 'so '$SCRIPTPATH'/init.vim' >> ~/.vimrc
fi
