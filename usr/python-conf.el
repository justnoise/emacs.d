;----------------------------------------
; Python
;----------------------------------------
(setq python-mode-hook
      '(lambda ()
         "Turn off Indent Tabs mode."
         (set (make-local-variable 'indent-tabs-mode) nil)
         
         (set-variable 'py-indent-offset 4)
         (set-variable 'tab-width 4)
         (show-paren-mode 1)
         (setenv "PYTHONPATH" ".")
         (load-library "py")))
