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
	     (load-library "py")))

;"/home/bcox/sandbox/sauce/lib"
;"/home/bcox/sandbox/sauce/cloud"
