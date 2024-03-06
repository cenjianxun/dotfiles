# echo "set prompt.sh ..."

# todo:显示后台进程个数

# 测试颜色：echo -e "\e[1;31mHello World\e[0m"
# 其他格式：
# 8-bit: \e[38;5;N，N是0-255之间的值；bold: \e[1;38;5;N]
# 24-bit: \e[38;2;R;G;B;
# zsh不需要ansi转义，%B表示bold，%F表示前景色

##################

# 非交互返回
[[ $- != *i* ]] && exit

#isZsh=$(env | grep SHELL | grep -i "/zsh$")
#isMac=$(uname | grep -i "Darwin")
#OS=${$(uname)%_*} # 也可以用 [[ $OS == "Darwin" ]]判断，linux是“CYGWIN”和“MSYS”

function _get_head() {
	# 上个命令的返回值要放到函数内部的开头，不然它始终不变
	local preStatus=$?

	if [[ `uname` == "Darwin" ]]; then
    		head=""
	else
		# ip是linux用法，如果是macOS，`ip addr show `换成`ifconfig`
		ipStr=$(ip addr show | grep 'inet ' | grep -v 127.0.0.1 | awk 'NR==1 {print $2}' | awk -F'/' '{print $1}')
		# head="\u@${ipStr}"
	fi
	if [ -n "$ZSH_VERSION" ]; then
		if [[ `uname` == "Darwin" ]]; then
			echo -n "%(?.%B%F{Yellow}${head}%f%b.%B%F{88}${head}%f%b) "
		else
			echo -n "%B%F{Yellow}\u%f%b%(?.%B%F{Yellow}@%f%b.%B%F{88}@%f%b)%B%F{Yellow}${ipStr}%f%b "
		fi
	else
		#echo $preStatus
		if [[ `uname` == "Darwin" ]]; then
			[ $preStatus -eq 0 ] && echo "\[\e[1;33m\]${head}\[\e[0m\]" || echo "\[\e[1;31m\]${head}\[\e[0m\]"
		else
			[ $preStatus -eq 0 ] && echo "\[\e[1;33m\]\u\[\e[0m\]\[\e[1;32m\]@\[\e[0m\]\[\e[1;33m\]${ipStr}\[\e[0m\] " || echo "\[\e[1;33m\]\u\[\e[0m\]\[\e[1;31m\]@\[\e[0m\]\[\e[1;33m\]${ipStr}\[\e[0m\] "
		fi
	fi
}


function _get_pwd() {
	local shortPwd=$(pwd | sed "s|$HOME|~|" | sed "s:\([^/]\)[^/]*/:\1/:g")
	if [ -n "$ZSH_VERSION" ]; then
		echo "%B%F{blue}${shortPwd}%f%b "
	else
		echo "\[\e[1;32m\]${shortPwd}\[\e[0m\] "
	fi
}


# 很多直接用git branch命令提取，这个方法似乎快一点因为它是去找的缓存
# 在后面要直接调用，如果先生成值就不会更新了。
function _get_git_branch() {
    local _head_file _head
    local _dir="$PWD"

    while [[ -n "$_dir" ]]; do
        _head_file="$_dir/.git/HEAD"
        if [[ -f "$_dir/.git" ]]; then
            read -r _head_file < "$_dir/.git" && _head_file="$_dir/${_head_file#gitdir: }/HEAD"
        fi
        [[ -e "$_head_file" ]] && break
        _dir="${_dir%/*}"
    done


    if [[ -e "$_head_file" ]]; then
        read -r _head < "$_head_file" || return
        case "$_head" in
            ref:*) branch="${_head#ref: refs/heads/}" ;;
            "") ;;
            # HEAD detached
            *) branch="${_head:0:9}" ;;
        esac

        if [ -n "$ZSH_VERSION" ]; then
        	echo "%B%F{blue}[%f%b%F{15}${branch}%f%B%F{blue}]%f%b "
        else
        	echo "\[\e[1;32m\][\[\e[0m\]\[\e[1;37m\]${branch}\e[0m\]\[\e[1;32m\]]\[\e[00m\] "
        fi
        # return 0
    fi
    # return 1
}

### zsh 和 sh 赋值给交互命令时都需要使用single quote，是原样给它，它赋值的时候再计算。
# double quote 是直接计算好了，再给它它就不能算了，而且只变这一次新输入时候不动。
# 如果用自己的函数是这样的。所以为了严谨就都如此使用quote

if [ -n "$ZSH_VERSION" ]; then
	### If the PROMPT_SUBST option is set, the prompt string is first subjected to parameter expansion,
	# command substitution and arithmetic expansion
	setopt PROMPT_SUBST
	setopt transient_rprompt # 清除旧右提示符，方便复制
	# 这里%B就直接转到大写颜色那列了，%K的意思是将该颜色设为背景色而不是字本身
	export PROMPT='$(_get_head)$(_get_pwd)$(_get_git_branch)%B%F{Yellow}%(!.# .» )%f%b'
	export RPROMPT='%(?.%F{white}%*%f.%F{red}%*%f)'
else
	function build_prompt() {

		# root变色参考：
		# PS1='$(if [[ $? == 0 ]]; then echo "\[\e[1;32m\]:) "; else echo "\[\e[1;31m\]:( "; fi)$(if [[ ${EUID} == 0 ]]; then echo "\[\e[1;31m\]\u "; else echo "\[\e[1;36m\]\u "; fi)$(echo "\[\e[1;32m\]\w ")$(if [[ -d .git ]]; then echo "\[\e[1;33m\](`git status | head -n 1 | grep -o "\b\S*$"`) "; fi)$(if [[ ${EUID} == 0 ]]; then echo "\[\e[1;31m\]\$ "; else echo "\[\e[1;36m\]\$ "; fi)\[\e[0m\]'

		PS1=$(_get_head)
		PS1+='\[\e[1;32m\]\w\[\e[0m\] '
		PS1+=$(_get_git_branch)
		PS1+='\[\e[1;33m\]\$\[\e[0m\] '
}
	PROMPT_COMMAND=build_prompt
fi
