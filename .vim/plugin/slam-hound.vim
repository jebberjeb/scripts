" Require fireplace.vim
function! s:ClojureSlamHound(file)
    if &modified
        echom "Buffer contains unsaved changes!"
        return 1
    endif
    call fireplace#session_eval(
        \   '(clojure.core/require (quote slam.hound) (quote clojure.pprint))'
        \ . '(let [file (clojure.java.io/file "' . a:file . '")]'
        \ . '  (binding [clojure.pprint/*print-right-margin* 80]'
        \ . '    (slam.hound/swap-in-reconstructed-ns-form file)))'
        \ )
    edit
endfunction

nnoremap <leader>sh :call <SID>ClojureSlamHound(expand('%'))<CR>
