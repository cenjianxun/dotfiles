# 两种
# bash sync.sh up 是local改了传到dotfiles
# bash sync.sh down 是dotfiles给local

RIME_PATH="$HOME/Library/Rime"

if [ "$1" == "up" ]; then
	cp $RIME_PATH/default.custom.yaml .
	cp $RIME_PATH/symbols.yaml .
	cp $RIME_PATH/squirrel.custom.yaml .
	cp $RIME_PATH/luna_pinyin.custom.yaml .
fi

if [ "$1" == "down" ]; then
	cp *.yaml $RIME_PATH/
fi
