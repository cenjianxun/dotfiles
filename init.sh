# echo "start init.sh ..."
# start=$(python -c 'import time; print(time.time())')

# 防止被加载两次
#echo "看看before: $_INIT_SH_LOADED"
if [ -z "$_INIT_SH_LOADED" ]; then
	_INIT_SH_LOADED=1
else
	return
fi
#echo "看看after: $_INIT_SH_LOADED"

# 非交互式则退出
#[[ "$-" != *i* ]] && exit

#DOTDIR=/Users/dotfiles
# 环境配置
[ -f "$DOTDIR/config.sh" ] && . "$DOTDIR/config.sh"

# 提示符配置 全局
# default: export PROMPT="%n@%m %1~ %#"
[ -f "$DOTDIR/prompt.sh" ] && . "$DOTDIR/prompt.sh"

# 整理 PATH，删除重复路径
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}      
        case $PATH: in
           *:"$x":*) ;;         
           *) PATH=$PATH:$x;;  
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

export PATH

# 手边没有sh，先配zsh吧
if [ -n "$ZSH_VERSION" ]; then
	. "$DOTDIR/zshrc.zsh"
else
	[ -f "$HOME/.bashrc"  ] && . "$HOME/.bashrc"
fi

# end=$(python -c 'import time; print(time.time())')
# timeTaken=$(echo "$end - $start" | bc)
# echo "init运行时间：$timeTaken s"