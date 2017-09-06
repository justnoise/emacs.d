(add-hook 'go-mode-hook
	  (lambda ()
	    (set-variable 'c-basic-offset 4)
	    (set-variable 'tab-width 4)
	    (setq gofmt-command "goimports")
	    (add-to-list 'exec-path "/usr/local/go/bin/gofmt")
	    (add-hook 'before-save-hook 'gofmt-before-save)
	    (local-set-key (kbd "C-.") 'godef-jump)
	    (local-set-key (kbd "C-,") 'pop-tag-mark)
	    ))


;; (add-to-list 'load-path "/home/you/somewhere/emacs/")
;; (require 'go-mode-load)
;; (add-hook 'before-save-hook 'gofmt-before-save)
