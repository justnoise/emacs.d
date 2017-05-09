(require 'rvm)
;; (rvm-use-default) ;; use rvm's default ruby for the current Emacs session

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)

(require 'robe)
(defun setup-robe-mode ()
  (inf-ruby-minor-mode)
  (robe-mode)
  ;; add these guys so they match navigation in jedi (python)
  (define-key robe-mode-map (kbd "C-.") 'robe-jump)
  (define-key robe-mode-map (kbd "C-,") 'pop-tag-mark))

(add-hook 'ruby-mode-hook
	  (lambda ()
	    ;; (require 'flymake-ruby)
	    ;; (flymake-ruby-load)
	    (set (make-local-variable 'indent-tabs-mode) t)
	    (column-number-mode)
	    (setq ruby-indent-level 2)
	    (set-variable 'tab-width 2)
	    (add-to-list 'before-save-hook 'delete-trailing-whitespace)
	    (setup-robe-mode)))
