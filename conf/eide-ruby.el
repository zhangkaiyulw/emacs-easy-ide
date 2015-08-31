;; Ruby

(require 'ruby-mode)

;; ruby file extensions
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Beanfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.irbrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.pryrc\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Podfile\\'" . ruby-mode))

;; compilation
(require 'ruby-compilation)

(define-key ruby-mode-map (kbd "s-R") 'ruby-compilation-this-buffer)

;; inferior ruby
(require 'inf-ruby)
(require 'ac-inf-ruby)
(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (ac-inf-ruby-enable)
            (auto-complete-mode)))

;; electric pair
(add-hook 'ruby-mode-hook 'electric-pair-mode)

;; ri documentation
(require 'yari)
(global-set-key (kbd "C-h y") 'yari-helm)

;; yasnippet
(add-hook 'ruby-mode-hook 'yas-minor-mode-on)

;; syntax
(add-hook 'ruby-mode-hook
          '(lambda ()
             (modify-syntax-entry ?$ "w")
             (modify-syntax-entry ?@ "w")
             (modify-syntax-entry ?: ".")

             ;; indent guide
             (indent-guide-mode)
             ;; (setq indent-guide-recursive t)

             ))

;; support yard syntax
(require 'yard-mode)
(add-hook 'ruby-mode-hook 'yard-mode)

;; whitespace cleaning
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq-local whitespace-style '(empty indentation::space
                                                  space-befure-tab::space
                                                  trailing
                                                  whitespace-style::space))
             (add-hook 'before-save-hook 'whitespace-cleanup)))

;; do not deep indent
(setq ruby-deep-indent-paren nil)

;; guard
;; (require 'ruby-guard)

;; rake
(eval-after-load "rake"
  '(setq rake-cache-file (f-expand "rake.cache" eide-etc-dir)))

;; code folding
(add-hook 'ruby-mode-hook 'origami)

(provide 'eide-ruby)
