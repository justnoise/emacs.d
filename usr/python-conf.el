;----------------------------------------
; Python
;----------------------------------------

;; (defvar font-lock-debug-face
;;   'font-lock-format-specifier-face
;;   "Face name to use for format specifiers.")

;; (defface font-lock-debug-face
;;   '((t (:foreground "OrangeRed1")))
;;   "Font Lock mode face used to highlight format specifiers."
;;   :group 'font-lock-faces)


(add-hook 'python-mode-hook
	  (lambda ()
;; (font-lock-add-keywords
;;       'python-mode
;;       '(("\\(^\\ *pdb.set_trace\\)" 1 font-lock-warning-face t)))

	     ;; (font-lock-add-keywords
	     ;;  'python-mode
	     ;;  '(("\\<\\(pdb.set_trace\\)\\>" nil font-lock-warning-face t)))
	     ;; (font-lock-add-keywords
	     ;;  'python-mode
	     ;;  '(("\\(pdb.set_trace\\)" nil font-lock-warning-face t)));; custom-invalid t)))  ;; font-lock-warning-face t)))

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
