# echo "set bashrc.bash .."

# 上下键前缀搜索历史
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# 临时想显示prompt
PS1='[\u@$(hostname -I | awk "{print $1}")\w]\$ '