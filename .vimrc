" greatghoul's vimrc
" vim:set ft=vim et tw=78 sw=2:

""" Start pathogen plugin
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

""" GUI Settings
set guioptions-=T               " hide the toolbar
set ruler                       " show the cursor position all the time
set number                      " show line number

""" General
set nocompatible                " close vi mode
syntax on                       " auto syntax highlighting
filetype on                     " enable filetype 
filetype plugin indent on       " find type in .vim/ftplugin/
if has('gui_running')
  set background=dark           " Use light background in terminal
  let g:solarized_italic=0      " Disable italic text in solarized
  colors solarized                " set syntax color to desert
else
  colors evening
  "colors ron
endif
set autowrite                   " auto write the file content while jumping
set wildignore=*.swp,*.bak,*.pyc,*.class " ignore autocomplete filename list
set nobackup                    " disable backup file
set noswapfile                  " disable wrap file
set wildmenu                    " turn on wild menu, try typing :h and press <Tab> 
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set showcmd                     " display incomplete commands
set autochdir
""" Indentation & Formatting
set autoindent                  " enable auto indentation
set copyindent                  " auto indent as the previous line
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set smarttab                    " enable smart indentation
set expandtab                   " Insert spaces as tabs
set shiftwidth=4                " Number of spaces to use for each step of (auto)indent
"set textwidth=120               " auto break line at 120 characters
set colorcolumn=120           " Highlight right margin  
set tabstop=4                   " A tab means 4 spaces
filetype plugin indent on
filetype indent on

""" Language & Encoding
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,latin1
set langmenu=en_US.utf-8
source $VIMRUNTIME/delmenu.vim  " remove the menu
source $VIMRUNTIME/menu.vim     " load the menu
" source $VIMRUNTIME/mswin.vim    " enable mswin functions
language messages en_US.utf-8  

" statusline 
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\   " buffer number
set statusline+=\ %f
set statusline+=\ %{&ff=='unix'?'\\n':(&ff=='mac'?'\\r':'\\r\\n')}
set statusline+=\ %{&fenc!=''?&fenc:&enc}
set statusline+=\ %Y  "file type
set statusline+=\ %{getcwd()}          " current dir
set statusline+=\ %=%-10.(%l,%c%V%)\ %p%%  " Right aligned file nav info
set statusline+=\ %#warningmsg#
set statusline+=\ %*

if has("gui_running")
    au GUIEnter * simalt ~x  " 窗口启动时自动最大化
    "winpos 20 20            " 指定窗口出现的位置，坐标原点在屏幕左上角
    "set lines=20 columns=90 " 指定窗口大小，lines为高度，columns为宽度
    "set guioptions-=m       " 隐藏菜单栏
    set guioptions-=T        " 隐藏工具栏
    "set guioptions-=L       " 隐藏左侧滚动条
    "set guioptions-=r       " 隐藏右侧滚动条
    "set guioptions-=b       " 隐藏底部滚动条
    "set showtabline=0       " 隐藏Tab栏
endif

:inoremap ( ()<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i

:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <c-r>=ClosePair(']')<CR>

":inoremap < <><ESC>i

":inoremap > <c-r>=ClosePair('>')<CR>

:inoremap " ""<ESC>i

:inoremap ' ''<ESC>i

:inoremap ` ``<ESC>i

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

""" Search
set showmatch                   " show matching brackets
set hlsearch                    " highlighting searching
set incsearch                   " do incremental searching
set ignorecase                  " Set search/replace pattern to ignore case 
set smartcase                   " Set smartcase mode on, If there is upper case character in the search patern
                                " the 'ignorecase' option will be override.

""" Key Mappings
let g:mapleader=','
nmap <leader>u 	:MRU<CR>        
nmap <leader>nt :NERDTreeFind<CR>
nmap <leader>fe :NERDTree<CR>:NERDTreeMirror<CR>
nmap <leader>e 	:NERDTreeToggle<CR>:NERDTreeMirror<CR>
nmap <leader>l 	:TagbarToggle<CR>

" Ctrl-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Alt-]  - Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      
" [[ jump out of the tag stack (undo Ctrl-])
map [[ :po<CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Open a new tab
"map <C-t> :tabnew<CR>
" Close current tab
map <C-x> :tabclose<CR> 
" Clearing highlighted search
nmap <C-l> :nohlsearch<CR>
" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>
" Change Working Directory to that of the current file
nmap <leader>cd :lcd %:p:h<CR>

au BufEnter,BufNew *.py map <F5> :!python % <CR>

" Syntax *.json file as javascript
au BufNewFile,BufRead *.json            setf javascript
" Syntax *.hta file as html
au BufNewFile,BufRead *.hta             setf html
" Set sae wsgi file as python syntax
au BufNewFile,BufRead *.wsgi            set ft=python


au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""" NERDTree Settings
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.git', '\.hg', '\.svn', '\.dsp', '\.opt', '\.plg', '*.exe', '*.dll']



" 格式化xml
function Xml()
    set filetype=xml
    :%s/></>\r</g "把><替换成>回车<
    :normal gg=G<CR>
endfunction
map  <leader>xml  :call Xml()<CR>
"获取当前路径的上一级的路径
function! GET_UP_PATH(dir)
    let pos=len(a:dir)-1
    while pos>0
        if (a:dir[pos]=="/" )
            return  strpart(a:dir,0,pos)
        endif
        let pos=pos-1
    endwhile
    return  ""
endfunction

"设置相关tags
function! s:SET_TAGS()
    let dir = expand("%:p:h") "获得源文件路径
    "在路径上递归向上查找tags文件
    while dir!=""
        if findfile("tags",dir ) !=""
            "找到了就加入到tags
            exec "set tags+=" . dir . "/tags"
        endif
        "得到上级路径
        let dir=GET_UP_PATH(dir)
    endwhile
endfunction

autocmd BufEnter * call s:SET_TAGS()

