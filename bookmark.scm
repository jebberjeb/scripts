(print "Bookmark.scm loaded")

(require (prefix-in vim- 'vimext))

(vim-get-win-num (vim-curr-win))

(define wins (make-hash))
(hash-set! wins "foo" "bar")

;; Get your current (win, buf, line)
(define (get-place)
  (list (vim-get-win-num (vim-curr-win))
        (vim-get-buff-num (vim-curr-buff))
        (car (vim-get-cursor (vim-curr-win)))))

;; TODO - Since get-place is working, add push/pop bookmarks, probably using
;; cons/cdr -- we'll need to use a stack per window (in the hash).

;; Move this to .vim
(vim-command "nnoremap <leader>bmp :mz (hash-ref wins \"foo\")<cr>")
(vim-command "nnoremap <leader>bma :mz (get-place)<cr>")
