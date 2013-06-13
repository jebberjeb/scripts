" This is standard pathogen and vim setup
set nocompatible
call pathogen#infect() 

" General configuration
syntax on
filetype plugin indent on
autocmd Filetype html setlocal ts=2 sts=2 sw=2
set nu
set cc=80
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set backspace+=indent,eol,start
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" General custom mappings 
imap jj <Esc>
nmap \b :buffers<CR>
"nmap bn :bn<CR>
"nmap bp :bp<CR>

" Tag stuff (ctags, taglist.vim)
let Tlist_WinWidth=40
let tlist_clojure_settings='lisp;f:function'
map tl :TlistToggle<cr>
map tn :tn<cr>
map tp :tp<cr>
map gtl :!/usr/bin/ctags --langmap=lisp:+.clj -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Nerd Tree
map nt :NERDTree<cr>

" Stuff to avoid C-w, which doesn't play nice w/ chrome terminal
map <C-h> <C-w>h<CR>
map <C-l> <C-w>l<CR>

" Fireplace stuff
map eval :%Eval<CR>

" Command-T
let g:CommandTMaxFiles=50000
let g:CommandTMaxDepth=20

" Paredit
let g:paredit_mode = 1

" Default colorscheme
:colorscheme vividchalk
