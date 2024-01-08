" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 将 init.vim 目录加入 runtimepath
exec 'set rtp+='.s:home

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
"set rtp+=~/.vim

if ! has("gui_running")                " fix alt key under terminal
"    for i in range(48, 57) + range(65, 90) + range(97, 122)
"        exec 'set <A-' . nr2char(i) . '>=^[' . nr2char(i)
"    endfor
	let c='a'
	while c <= 'z'
    	exec "set <M-".toupper(c).">=\e".c
    	exec "imap \e".c." <M-".toupper(c).">"
    	let c = nr2char(1+char2nr(c))
  	endw
endif
"----------------------------------------------------------------------
" 初始配置
"----------------------------------------------------------------------

" 正常显示中文
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

syntax on  " 语法高亮
set nu!  " 显示行号
set wrap  " 自动换行
set scrolloff=5  " 上下移动光标时，光标的上方或下方至少会保留显示的行数
set mouse=v " 开启鼠标 默认是a，设v可鼠标选中复制到寄存器；但是v不能鼠标点哪移哪
set ai!  " 设置自动缩进
set ruler  " 显示光标位置
set showcmd  " 显示命令
"set incsearch  " 查词时自动前缀匹配
"set showmatch  " 设置匹配模式，like补齐左右括号
set autoindent " 自动缩进
set tabstop=4  " 设置tab键为4个空格
set backspace=2  " 设置退格键可用
set ignorecase  " 搜索时忽略大小写
set smartcase  " 配合ignorecase使用，大写精确匹配，小写忽略大小写
"set noerrorbells  " 出错静音
"set visualbell  " 出错屏幕闪烁
" shift-tab 缩回 for command mode
nnoremap <S-Tab> <<
" shift-tab 缩回 for insert mode
inoremap <S-Tab> <C-d>
set backspace=2  " 设置退格键可用
set laststatus=2  " 0:不显示状态行；1:多于一个窗口显示；2:总显示状态行
" 缓冲区号 文件名 行数 修改 帮助 只读 编码 换行符 BOM ======== 字符编码 位置 百分比位置
set statusline=%n\ %<%f\ %LL\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P

" 打开vim, 自动定位到上次最后变更位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 设置代码折叠
if has('folding')
	set foldenable  " 允许代码折叠
	set fdm=indent  " 代码折叠默认使用缩进
	set foldlevel=99  " 默认打开所有缩进
endif

" 键映射 
" nore：非循环模式；v：visual模式；i：insert模式
"  用分号输命令
nnoremap ; :
" 查看寄存器：:reg
set clipboard=unnamed  " 将vim寄存器连接系统剪贴板；要vim --version ｜ grep clipboard 看是否有+clipboard 

if has("macunix")
	" CTRL-A Select all
	noremap <C-a> gggH<C-O>G
	inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
	cnoremap <C-A> <C-C>gggH<C-O>G
	onoremap <C-A> <C-C>gggH<C-O>G
	snoremap <C-A> <C-C>gggH<C-O>G
	xnoremap <C-A> <C-C>ggVG
	" CTRL-X Cut
	inoremap <C-x> "+x
	" CTRL-C Copy
	noremap <C-c> "+y
	inoremap <C-c> <C-o>"+y
	" CTRL-V Paste
	noremap <C-v> "*p
	inoremap <C-v> <Esc>"*p
	" CTRL-S saving
	nnoremap <C-S> :update<CR>
	vnoremap <C-S> <ESC>:update<CR>
	inoremap <C-S> <ESC>:update<CR>
	" CTRL-Z  Undo
	noremap <C-z> u
	inoremap <C-z> <C-O>u
	" CTRL-SHIFT-Z Redo
	noremap <C-S-z> <C-R>
	inoremap <C-S-z> <C-O><C-R>

	silent! execute "set <M-z>=\<Esc>z"

	" 方向
	noremap <A-Left> b
	noremap <C-Left> 0
	noremap <A-Right> w
	noremap <C-Right> $
	noremap <C-Up> <C-u>  " 向上半屏
	noremap <C-Down> <C-d>  " 向下半屏
	noremap <A-Backspace> bX
	noremap <C-Backspace> dd
"else
endif


" 括号匹配
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ) <C-R>=ClosePair(')')<CR>
inoremap ] <C-R>=ClosePair(']')<CR>
inoremap } <C-R>=ClosePair('}')<CR>
inoremap " <C-R>=QuoteDelim('"')<CR>
inoremap ' <C-R>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
    else
        "Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endf

"----------------------------------------------------------------------
" 如果要模块加载
"----------------------------------------------------------------------

" 定义一个命令用来加载文件
"command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'

" 自定义按键
"LoadScript init/init-keymaps.vim
