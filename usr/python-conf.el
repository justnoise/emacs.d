;----------------------------------------
; Python
;----------------------------------------
(add-hook 'python-mode-hook
	  (lambda ()
	     "Turn off Indent Tabs mode."
	     (set (make-local-variable 'indent-tabs-mode) nil)
	     (set-variable 'py-indent-offset 4)
	     (set-variable 'tab-width 4)
	     (show-paren-mode 1)
	     (column-number-mode)
	     ;;(setenv "PYTHONPATH" ".:/home/bcox/sauce/lib:/home/bcox/sauce/cloud")
	     ;;
	     ;; If deleting trailing whitespace for all files gets old, have a
	     ;; helper function that only does it if the current buffer is python-mode
	     (add-to-list 'before-save-hook 'delete-trailing-whitespace)
	     (load-library "py")))

;"/home/bcox/sandbox/sauce/lib"
;"/home/bcox/sandbox/sauce/cloud"
