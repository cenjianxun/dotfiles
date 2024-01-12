# 两种
# bash sync.sh up 是local改了传到dotfiles
# bash sync.sh down 是dotfiles给local

PATH="/Users/liukun/Library/Rime"

if $0 == 'up'; then
	cp $PATH/default.custom.yaml ./
	cp $PATH/symbols.yaml ./
	cp $PATH/squirrel.custom.yaml ./
	cp $PATH/luna_pinyin.custom.yaml ./
fi

if $0 == 'down'; then
	cp default.custom.yaml $PATH/
	cp symbols.yaml $PATH/
	cp squirrel.custom.yaml $PATH/
	cp luna_pinyin.custom.yaml $PATH/
fi