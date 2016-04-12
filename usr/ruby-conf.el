(add-hook 'ruby-mode-hook
	  (lambda ()
	    (set (make-local-variable 'indent-tabs-mode) t)
	    (column-number-mode)
	    (setq ruby-indent-level 2)
	    (set-variable 'tab-width 2)
	    (add-to-list 'before-save-hook 'delete-trailing-whitespace)))
