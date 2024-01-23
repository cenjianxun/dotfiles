RIME_PATH="$HOME/Library/Rime"
config_files=(default.custom.yaml squirrel.custom.yaml symbols.yaml luna_pinyin.custom.yaml)

# -------- 废弃 ---------

# 两种
# bash sync.sh up 是local改了传到dotfiles
# bash sync.sh down 是dotfiles给local

# if [ "$1" == "up" ]; then
# 	cp $RIME_PATH/default.custom.yaml .
# 	cp $RIME_PATH/symbols.yaml .
# 	cp $RIME_PATH/squirrel.custom.yaml .
# 	cp $RIME_PATH/luna_pinyin.custom.yaml .
# fi

# if [ "$1" == "down" ]; then
# 	cp *.yaml $RIME_PATH/
# fi


# ------- 更新方案！-------
# 使用软链接方式同步。（先删除RIME_PATH下的config_files）
# 只运行一次就行

# ln -s $PWD/symbols.yaml $RIME_PATH/symbols.yaml

for rfile in "${config_files[@]}"; do
	ln -s $PWD/$rfile $RIME_PATH/$rfile
done
