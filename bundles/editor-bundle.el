(setq-default
 indent-tabs-mode nil ;; use whitespace to indent
 tab-width 2          ;; tab width 2
 make-backup-files nil ;; do not backup files
 ;; initial-major-mode 'ruby-mode ;; initial major mode
 fill-column 80
 )

;; Local variable safety
(setq enable-local-variables nil)
(setq enable-local-eval nil)

;; exec path
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; project
(require 'projectile)
(projectile-global-mode)

;; searching
(require 'anzu)
(global-anzu-mode t)
(global-set-key (kbd "M-%") 'anzu-query-replace-regexp)
(global-set-key (kbd "C-M-%") 'anzu-query-replace)

;; jumping
(require 'ace-jump-mode)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(global-unset-key (kbd "C-;"))
(global-unset-key (kbd "M-;"))
(define-key global-map (kbd "C-;") 'ace-jump-char-mode)
(define-key global-map (kbd "C-:") 'ace-jump-word-mode)
(define-key global-map (kbd "C-M-;") 'ace-jump-line-mode)

;; dash
(global-set-key (kbd "C-h D") 'dash-at-point)

;; swoop
(require 'helm-swoop)
(global-set-key (kbd "C-z") 'helm-swoop)

;; global auto revert
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; undo
(require 'undo-tree)
(global-undo-tree-mode)

;; global hippie expand
(global-set-key (kbd "M-/") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

;; expand region
(defalias 'save-mark-and-excursion 'save-excursion)
(defmacro save-mark-and-excursion (&rest body)
  `(save-excursion ,@body)) ;; fixed a bug
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Mark
(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)

;; kill back to indentation
(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "s-M-<backspace>") 'kill-back-to-indentation)

;; move line up and down
(require 'move-dup)
(global-set-key [s-down] 'md/move-lines-down)
(global-set-key [s-up] 'md/move-lines-up)
(global-set-key [M-s-down] 'md/duplicate-down)
(global-set-key [M-s-up] 'md/duplicate-up)

;; whole line or region
(require 'whole-line-or-region)
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

;; highlight escape sequences
(require 'highlight-escape-sequences)
(hes-mode)

;; ignore and next line
(defun ignore-this-line-and-move-to-next-line ()
  "Ignore this line and move to next line."
  (interactive)
  (next-line)
  (move-end-of-line 1))
(global-set-key [M-s-return] 'ignore-this-line-and-move-to-next-line)

(defun ignore-this-line-and-open-new-line ()
  "Ignore this line and open new line below."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))
(global-set-key [s-return] 'ignore-this-line-and-open-new-line)

;; add new line if no lines
(setq next-line-add-newlines t)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)

;; C-a should go back to indentation and then line beginning
(defun ky/back-to-indentation-or-beginning-of-line ()
  (interactive)
  (let ((p (point)))
    (back-to-indentation)
    (if (= p (point))
        (move-beginning-of-line 1))))
(global-set-key (kbd "C-a") 'ky/back-to-indentation-or-beginning-of-line)

;; Use M-m for helm-imenu
(global-set-key (kbd "M-m") 'helm-imenu)

;; M-n and M-p to navigate around symbol at point
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; Snippets
(require 'yasnippet)
(setq yas-snippet-dirs (remove 'yas-installed-snippets-dir yas-snippet-dirs))
(yas-reload-all)

;; expand macro
(require 'macrostep)

;; comment do what i mean
(global-set-key (kbd "s-;") 'comment-dwim)

(provide 'editor-bundle)