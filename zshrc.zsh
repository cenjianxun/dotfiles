#!/bin/zsh

# echo "set zshrc.zsh .."
# start=$(python -c 'import time; print(time.time())')

# 自动补全 代码高亮 前缀搜索
needPackages=(zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
brewPrefix=$(brew --prefix)
for pkg in "${needPackages[@]}"; do
	if ! source "$brewPrefix/share/$pkg/$pkg.zsh" 2> /dev/null; then
		echo "Installing $pkg..."
		brew install "$pkg"
		# 直接给path赋值的话，报错很危险。恢复默认值：export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH
		source "$brewPrefix/share/$pkg/$pkg.zsh"
	fi
done

# zsh设置用setopt，关掉用unsetopt
# 删除keymaps：bindkey -d；
# restart zsh：exec zsh

# misc
setopt auto_cd  # 不用cd打开文件
setopt AUTO_LIST # 自动补全
setopt AUTO_MENU
#setopt MENU_COMPLETE  # 补全时会直接选中菜单项
setopt noflowcontrol  # 关闭流控功能
#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# history
# HISTFILE=~/.zsh_history
setopt BANG_HIST # 在展开字符期间对"!"特殊处理
setopt INC_APPEND_HISTORY  # 附加写入历史纪录
unsetopt SHARE_HISTORY  # 不要在各个终端窗口中共享历史记录
setopt HIST_EXPIRE_DUPS_FIRST  # 修剪掉过量的历史记录时首先去重复
setopt HIST_IGNORE_DUPS  # 不记录刚刚记录的内容
setopt HIST_IGNORE_ALL_DUPS  # 如果新内容重复，则删除旧内容
setopt HIST_SAVE_NO_DUPS  # 不要在历史文件中写入重复的条目
setopt HIST_REDUCE_BLANKS  # 在记录条目之前删除多余的空白
setopt hist_ignore_space  # 在命令前添加空格，不将此命令添加到记录文件中
setopt nobeep nohistbeep nolistbeep  # 声音关掉

# Setup dir stack
DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups cdablevars
alias d='dirs -v | head -10'

# bind
# ctrl显示图形：cmd；alt显示：option；cmd显示：^
#bindkey '^[z' undo  # [ctrl-z]
#bindkey '^[Z' redo  # [ctrl-shift-z]
#bindkey '\e[3~' delete-char  # [del]
bindkey '^[[1;3D' backward-word  # [ctrl-left]
bindkey '^[[1;3C' forward-word  # [ctrl-right]
bindkey '^[[1;5D' beginning-of-line  # [alt-left]
bindkey '^[[1;5C' end-of-line  # [alt-right]
bindkey '^[[3;5~' kill-word  # [alt-del]
bindkey '^H' backward-kill-word  # [alt-backspace]
bindkey '^[[3~' kill-line  # [ctrl-del]
bindkey '^[^?' backward-kill-line  # [ctrl-backspace] ^[[3;3~
# push-line，当输入一半命令的时候想输入其他命令
bindkey "\eq" push-line-or-edit

# 上下键前缀搜索历史
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# 没sudo的命令自动添加，加了的去掉
sudo-command-line() {
	[[ -z $BUFFER ]] && zle up-history
	local cmd="sudo "
	if [[ ${BUFFER} == ${cmd}* ]]; then
		CURSOR=$(( CURSOR-${#cmd} ))
		BUFFER="${BUFFER#$cmd}"
	else
		BUFFER="${cmd}${BUFFER}"
		CURSOR=$(( CURSOR+${#cmd} ))
	fi
	zle reset-prompt 
}
zle -N sudo-command-line
bindkey "^D" sudo-command-line

# end=$(python -c 'import time; print(time.time())')
# timeTaken=$(echo "$end - $start" | bc)
# echo "zshrc.zsh运行时间：$timeTaken s"	}
