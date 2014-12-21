(add-hook 'go-mode-hook
	  (lambda ()
	    (set-variable 'c-basic-offset 4)
	    (set-variable 'tab-width 4)
	    (setq gofmt-command "goimports")
	    (local-set-key (kbd "C-.") 'godef-jump)))


;; (add-to-list 'load-path "/home/you/somewhere/emacs/")
;; (require 'go-mode-load)
;; (add-hook 'before-save-hook 'gofmt-before-save)
