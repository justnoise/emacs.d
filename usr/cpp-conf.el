
;----------------------------------------
; c++
;----------------------------------------

;;; Code:

(add-to-list 'auto-mode-alist
     	     '("\\.h\\'" . c++-mode))

(autoload 'gtags-mode "gtags" "" t)

(load-library "cpp")
(add-hook 'c++-mode-hook
	  '(lambda ( )
	     (c-set-style "Stroustrup")
	     (gtags-mode t)
	     (global-set-key (kbd "C-.") 'gtags-find-tag-from-here)
	     (global-set-key (kbd "C-,") 'gtags-pop-stack)

	     (setq c-basic-offset 4)
	     (setq tab-width 4)
					;(c-toggle-auto-state)
	     ;;(global-set-key [f11] 'assistant)
	     ;;(global-set-key "\C-c>" 'indent-region)
	     (setq-default indent-tabs-mode nil)
	     (global-set-key "\C-co" 'ff-find-related-file)
	     (global-set-key "\C-c\C-v" 'uncomment-region)
	     (global-set-key "\C-c|" 'align-regexp)
	     ))
	     ;;(load-library "cpp")
;; ----------------------------------------
;; KBD Macros
;; (fset 'cppsql-to-sql
;;    (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\372\"\"" 0 "%d")) arg)))

(provide 'cpp-conf)
;;; cpp-conf.el ends here
