# 两种
# bash sync.sh up 是local改了传到dotfiles
# bash sync.sh down 是dotfiles给local

RIME_PATH="/Users/liukun/Library/Rime"

if [ "$1" == "up" ]; then
	cp $RIME_PATH/*.yaml .
fi

if [ "$1" == "down" ]; then
	cp *.yaml $RIME_PATH/
fi