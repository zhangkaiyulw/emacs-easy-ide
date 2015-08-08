;;; Using meta-backtip to open menu bar on terminal

(define-key global-map (kbd "M-`") 'menu-bar-open)

;;; Do not show toolbar

(tool-bar-mode -1)

;;; Do not show scroll bar

(scroll-bar-mode -1)

;;; Do not show startup screen

(setq-default
 inhibit-splash-screen t                ;; disable splash screen
 initial-scratch-message "\n"           ;; empty initial message
 )

;; Disable the beep sound

(setq-default visible-bell t) ;; do not beep
(setq ring-bell-function (lambda () ()))

;;; Fringe

(set-fringe-mode '(10 . 10))
(add-to-list 'default-frame-alist '(width . 83))

;;; Global default font

(set-face-attribute 'default nil :height 130)

;;; Pretty symbol

(global-prettify-symbols-mode)

;;; y-or-n-p

(defalias 'yes-or-no-p 'y-or-n-p)

;;; ESC to quit

(if window-system
    (global-set-key (kbd "<escape>") 'keyboard-quit))

;;; scroll preserve screen position

(setq scroll-preserve-screen-position 'always)

;; Ido interface
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-file-extensions-order '(".rb" ".coffee" ".js" ".erb"
                                  ".c" ".html" ".md" ".py" ".el" ".es6"))
(setq ido-ignore-files '(".DS_Store"))
(setq ido-use-filename-at-point nil) ;; do not guess my taste

;; Display ido results vertically, rather than horizontally
(setq ido-decorations
      (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]"
              " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable
                                            'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(ido-mode t)
(require 'ido-ubiquitous)
(ido-ubiquitous-mode)
(require 'smex)
(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(global-set-key [remap execute-extended-command] 'smex)

(global-set-key (kbd "s-P") 'smex)



;;; guide key

(require 'guide-key)
(setq guide-key/guide-key-sequence
      '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n"
        "C-x C-r"))
(guide-key-mode 1)
(diminish 'guide-key-mode)

;;; discover

(require 'discover)
(global-discover-mode)

;; helm
(require 'helm)
(require 'helm-config)
;; (require 'helm-projectile)
;; (helm-autoresize-mode)
(global-set-key (kbd "s-i") 'helm-mini)

(setq helm-M-x-fuzzy-match t)
(setq helm-recentf-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)
(setq helm-imenu-fuzzy-match t)
(setq helm-apropos-fuzzy-match t)


;; Calendar

(require 'calfw)

;;; themes

(if window-system
    (require 'base16-3024-dark-theme)
  (load-theme 'wombat t))

;;; Line number

;; disable linum function
(defun hy-core-ui-linumoff ()
  (linum-mode -1))

;; format
(setq-default  linum-format "%2d ")

;; disable in non-programming modes
(eval-when-compile (require 'linum-off))
(setq linum-diabled-modes-list
      '(eshell-mode compilation-mode org-mode help-mode dired-mode
                    doc-view-mode image-mode comint-mode))

;; fix for image mode (linum-off doesn't work here)
(add-hook 'image-mode-hook 'hy-core-ui-linumoff)

;; global line number
(global-linum-mode)
(add-hook 'linum-mode-hook 'hlinum-activate)
(eval-when-compile (require 'hlinum))
(set-face-foreground 'linum-highlight-face "#343d46")
(set-face-background 'linum-highlight-face "#65737e")

;; show column number at the status bar
(column-number-mode)

;;; Highlight current line

;; (global-hl-line-mode)

;; packages
(global-set-key [f9] 'package-install)
(global-set-key [M-f9] 'package-list-packages)
(global-set-key [s-f9] 'package-list-packages-no-fetch)

(provide 'hy-core-ui)
