(print "Bookmark.scm loaded")

(require (prefix-in vim- 'vimext))

(vim-get-win-num (vim-curr-win))

(define wins (make-hash))
(hash-set! wins "foo" "bar")

(define )

(define (get-place)
  "Get your current (win, buf, line)"
  (list (vim-get-win-num (vim-curr-win))
        (vim-get-buff-num (vim-curr-buff))
        (car (vim-get-cursor (vim-curr-win)))))

(define (pop-bookmark- win-num)
  (let ((win-stack (hash-ref wins win-num null)))
    (if (not (null? win-stack))
      (begin
        (hash-set! wins win-num (cdr win-stack))
        (car win-stack))
      null)))

(define (pop-bookmark)
  "Check the bookmarks for this window, grab the latest one."
  (pop-bookmark- (list-ref (get-place) 0)))

(define (push-bookmark- bookmark)
  (let ((win-num (list-ref bookmark 0))
        (win-stack (hash-ref wins (list-ref bookmark 0) null)))
    (hash-set! wins win-num (cons bookmark win-stack))))

(define (push-bookmark)
  "Add a bookmark to the stack for a window."
  (push-bookmark- (get-place)))

;; TODO - don't need pop anymore, since we're not actually going to pop, well
;; just use <- -> to move through them. So we need a current pointer. And when
;; a bookmark is added, the cur pointer is reset to the head.

;; Current pointer stuff -- Feels weak that we'd use two different structures,
;; rather than a hash to another hash or something. Yeah, I think, go w/ two
;; hashes, and allow the inner one to have two keys (cur, marks)

(define cur-ptr-by-win (make-hash))

(define (set-cur-ptr-head win-num)
  ;; TODO - set the cur ptr to the head for the win
  )

(define (move-cur-ptr-fwd win-num)
  ;; TODO - move the cur ptr forward, or roll to beg
  )

(define (move-cur-ptr-back win-num)
  ;; TODO - move the cur ptr back, or roll to head
  )

;; End Current pointer stuff

;; Move this to .vim
(vim-command "nnoremap <leader>bmp :mz (pop-bookmark)<cr>")
(vim-command "nnoremap <leader>bma :mz (push-bookmark)<cr>")
