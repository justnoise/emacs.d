;(add-to-list 'auto-mode-alist '("\\.pp\\'" . ruby-mode))
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (require 'flymake-ruby)
	    (flymake-ruby-load)
	    (set (make-local-variable 'indent-tabs-mode) t)
	    (column-number-mode)
	    (setq ruby-indent-level 2)
	    (set-variable 'tab-width 2)
	    (add-to-list 'before-save-hook 'delete-trailing-whitespace)))

;;(setq ruby-deep-indent-paren nil)
;;(require 'robe)
;;(add-hook 'ruby-mode-hook 'robe-mode)

;; look into adding flx-ido
