# echo "start init.sh ..."

# 必须先定义dotdir
DOTFILE=$(perl -e 'use Cwd "abs_path"; print abs_path(shift)' "$0")
DOTDIR=$(dirname $DOTFILE)
echo "DOTDIR 路径：$DOTDIR"

# 防止被加载两次
init_script() {
    # echo "看看before: $_INIT_SH_LOADED"
    if [ -z "$_INIT_SH_LOADED" ]; then
        _INIT_SH_LOADED=1
    else
        return  # 防止脚本被加载两次
    fi
    #echo "看看after: $_INIT_SH_LOADED"
}
 
init_script()



# 非交互式则退出
#[[ "$-" != *i* ]] && exit

#DOTDIR=/Users/[user]/dotfiles
# 环境配置
[ -f "$DOTDIR/config.sh" ] && . "$DOTDIR/config.sh"

# 提示符配置 全局
# default: export PROMPT="%n@%m %1~ %#"
[ -f "$DOTDIR/prompt.sh" ] && . "$DOTDIR/prompt.sh"

# 处理重复PATH
if [ -n "$PATH" ]; then
    # 去除重复的路径
    PATH=$(echo "$PATH" | tr ':' '\n' | sort -u | tr '\n' ':')
    # 删除最后的多余冒号
    PATH=${PATH%:}
fi

export PATH

# 手边没有sh，先配zsh吧
if which zsh >/dev/null; then
	. "$DOTDIR/zshrc.zsh"
else
	. "$DOTDIR/bashrc.bash"
fi