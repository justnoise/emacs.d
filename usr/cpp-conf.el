;----------------------------------------
; c++
;----------------------------------------

;; (add-to-list 'auto-mode-alist
;;      	     '("\\.h\\'" . c++-mode))

(load-library "cpp")
(add-hook 'c++-mode-hook
	  '(lambda ( )
	     (c-set-style "Stroustrup")
	     (setq c-basic-offset 2)
         (setq tab-width 2)
	     ;(c-toggle-auto-state)
	     (global-set-key [f11] 'assistant)
       ;;(global-set-key "\C-c>" 'indent-region)
       (global-set-key "\C-co" 'ff-find-related-file)
       (global-set-key "\C-c\C-v" 'uncomment-region)
       (global-set-key "\C-co" 'ff-find-related-file)
       (global-set-key "\C-c|" 'align-regexp)
       ))
	     ;;(load-library "cpp")
;; ----------------------------------------
;; KBD Macros
(fset 'cppsql-to-sql
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\372\"\"" 0 "%d")) arg)))


