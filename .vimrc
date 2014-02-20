"  is standard pathogen and vim setup
set nocompatible
call pathogen#infect()

" General configuration
syntax on
filetype plugin indent on
autocmd Filetype html setlocal ts=2 sts=2 sw=2
set nu
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set backspace+=indent,eol,start
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" General custom mappings
let mapleader = ","
inoremap jk <Esc>
"" In order to add <cr> to the mapped key,
"" we have to turn the sequence into a
"" string, and stringify the <cr>.
nnoremap <leader>dot :vsplit ~/.vimrc<cr>:execute ":nnoremap <buffer> q :w\<lt>cr>:bd\<lt>cr>"<cr>
nnoremap <leader>sdot :source ~/.vimrc<cr>
"" move lines
nnoremap <leader>lu :normal ddkkp<cr>
nnoremap <leader>ld :normal ddp<cr>

"" windows - not sure how wise this is as
"" it may cause me to lose dexterity w/
"" standard vim bindings.

""" moving between windows
nnoremap <leader>wq :q<cr>
nnoremap <leader>wh <c-w>h<cr>
nnoremap <leader>wj <c-w>j<cr>
nnoremap <leader>wk <c-w>k<cr>
nnoremap <leader>wl <c-w>l<cr>
""" sizing windows -- keep it fast,
""" repeated keystrokes
nnoremap <left> :vertical res -1<cr>
nnoremap <right> :vertical res +1<cr>
nnoremap <down> :res -1<cr>
nnoremap <up> :res +1<cr>
""" splitting windows -- removing, think it's worth knowing
""" the default vim bindings here.
"nnoremap <leader>vsplit :vnew<cr>
"nnoremap <leader>split :new<cr>

" Relearn a few things
inoremap <esc> <nop>
inoremap <c-[> <nop>

" Incubator (From LVstHW)

"" Functions (and mappings) which prepare
"" the window for copy color column, and 
"" line numbers.
function! ReadyToCopy()
    :set cc=0
    :set nonumber
    :set nolist
endfunction
function! NotReadyToCopy()
    :set cc=80
    :set number
    :set list
endfunction
nnoremap <leader>copy :call ReadyToCopy()<cr>
nnoremap <leader>nocopy :call NotReadyToCopy()<cr>

" Tag stuff (ctags, taglist.vim)
let Tlist_WinWidth=40
let tlist_clojure_settings='lisp;f:function'
nnoremap tl :TlistToggle<cr>
nnoremap tn :tn<cr>
nnoremap tp :tp<cr>
nnoremap gtl :!/usr/bin/ctags --langmap=lisp:+.clj -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Nerd Tree
nnoremap nt :NERDTree<cr>

" Stuff to avoid C-w, which doesn't play
" nice w/ chrome terminal
nnoremap <C-h> <C-w>h<CR>
nnoremap <C-l> <C-w>l<CR>

" Fireplace stuff
nnoremap <leader>eval :%Eval<CR>
nnoremap <leader>test :Eval (clojure.test/run-all-tests)<CR>

" Command-T
let g:CommandTMaxFiles=50000
let g:CommandTMaxDepth=20

" Paredit
let g:paredit_mode = 1

" Default colorscheme
colorscheme vividchalk
set cc=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" mzf experimentation stuff -- this would go in the
" plugin's .vim file, along w/ the other key mappings
nnoremap <leader>bms :mzf ~/scripts/.vim/vim-bookmark-mz/plugin/bookmark.scm<cr>
" something like <leader>eval, but for mz
function! EvalMz()
    :w
    :mzf %
endfunction
"nnoremap <leader>mz :call EvalMz()<cr>
nnoremap <leader>mz :!mzscheme -f %<cr>

" ------ Incubation ------

" Eval the Vimscript (or whatever) in current buffer
nnoremap <leader>run :w<cr> :so %<cr>
" Use VimShell -- at least the basics
"nnoremap <leader>sh :VimShell<cr>
" Create VimShell in vsplit
function! VSplitShell()
    :vnew
    :normal 
    :normal ,wl
    :VimShell
endfunction
nnoremap <leader>sh :call VSplitShell()<cr>

function! RunTests()
    " reload the namespace
    norm cpr

    " setup
    call clearmatches()
    highlight Red ctermbg=darkred
    redir => output

    " use Clojure to do the real work, run tests,
    " parse the results
    Eval (map #(subs % 9 (dec (count %))) (re-seq #"FAIL in \(\S*\)" (let [s# (new java.io.StringWriter)] (binding [*test-out* s#] (run-all-tests) (str s#)))))
    redir END

    " output will have the valid ('a-fn' 'b-fn')
    " strip off the parens, then split on space
    let output = output[2:len(output) - 2]
    let parts = split(output, ' ')
    for part in parts
        exec "call matchadd('Red'," . part . ")"
    endfor
endfunction

nnoremap <leader>tdd :call RunTests()<cr>
