" greatghoul's vimrc
" vim:set ft=vim et tw=78 sw=2:

""" Start pathogen plugin
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
colors desert                   " set syntax color to desert
set autowrite                   " auto write the file content while jumping
set wildignore=*.swp,*.bak,*.pyc,*.class " ignore autocomplete filename list
set nobackup                    " disable backup file
set noswapfile                  " disable wrap file
set wildmenu                    " turn on wild menu, try typing :h and press <Tab> 
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set showcmd                     " display incomplete commands

""" Indentation & Formatting
set autoindent                  " enable auto indentation
set copyindent                  " auto indent as the previous line
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set smarttab                    " enable smart indentation
set expandtab                   " Insert spaces as tabs
set shiftwidth=4                " Number of spaces to use for each step of (auto)indent
set textwidth=120               " auto break line at 120 characters
set tabstop=4                   " A tab means 4 spaces

""" Language & Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5
set langmenu=en_US.utf-8
source $VIMRUNTIME/delmenu.vim  " remove the menu
source $VIMRUNTIME/menu.vim     " load the menu
source $VIMRUNTIME/mswin.vim    " enable mswin functions
language messages en_US.utf-8  

" statusline {
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
map <F5>        :!%<CR>

" Ctrl-\ - Open the definition in a new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Alt-]  - Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      
" [[ jump out of the tag stack (undo Ctrl-])
map [[ :po<CR>
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Open a new tab
map <C-t> :tabnew<CR>
" Close current tab
map <C-x> :tabclose<CR> 
" Clearing highlighted search
nmap <C-l> :nohlsearch<CR>
" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>
" Change Working Directory to that of the current file
nmap <leader>cd :lcd %:p:h<CR>

" Syntax *.json file as javascript
au BufNewFile,BufRead *.json            setf javascript
" Syntax *.hta file as html
au BufNewFile,BufRead *.hta             setf html

""" NERDTree Settings
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.git', '\.hg', '\.svn', '\.dsp', '\.opt', '\.plg', '*.exe', '*.dll']

" TagBar Settings
let g:tagbar_width=30
let g:tagbar_compact=1
let g:tagbar_expand=1
let g:tagbar_autoshowtag=1
if executable('ctags.exe')
  let g:tagbar_ctags_bin='ctags.exe'
else
  let g:tagbar_ctags_bin='ctags'
endif
set tags=./tags,../../tags,$HOME/vimtags