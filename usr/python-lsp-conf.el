; (require 'lsp-python-ms)
;(setq lsp-python-ms-auto-install-server t)
; (add-hook 'python-mode-hook #'lsp) ; or lsp-deferred
;(setq flycheck-python-flake8-executable (concat (getenv "HOME") "/.virtualenvs/backend/bin/flake8"))
(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook
  ((python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp-deferred)
		   (set (make-local-variable 'indent-tabs-mode) nil)
		   (set-variable 'py-indent-offset 4)
		   (set-variable 'tab-width 4)
		   (show-paren-mode 1)
		   (column-number-mode)
		   (add-to-list 'before-save-hook 'delete-trailing-whitespace)
		   (load-library "py")))))
   ;; (flycheck-mode . (lambda ()
   ;; 		      (flycheck-add-next-checker 'lsp 'python-flake8)
   ;; 		      (flycheck-add-next-checker 'python-flake8 'python-mypy)
   ;; 		      (message "Added flycheck checkers.")))))
;; LSP checker doesn't exist until after it has been initialized
(add-hook 'lsp-after-initialize-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
	      (flycheck-add-next-checker 'lsp 'python-flake8)
	      (message "Added flycheck checkers."))))

(defvar font-lock-debug-face
  'font-lock-format-specifier-face
  "Face name to use for format specifiers.")

(defface font-lock-debug-face
  '((t (:foreground "OrangeRed1")))
  "Font Lock mode face used to highlight format specifiers."
  :group 'font-lock-faces)




;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    ;(setenv "WORKON_HOME" (concat (getenv "HOME") "/.virtualenvs"))
;; 	    ;; (font-lock-add-keywords
;; 	    ;;       'python-mode
;; 	    ;;       '(("\\(^\\ *pdb.set_trace\\)" 1 font-lock-warning-face t)))

;; 	    ;; (font-lock-add-keywords
;; 	    ;;  'python-mode
;; 	    ;;  '(("\\<\\(pdb.set_trace\\)\\>" nil font-lock-warning-face t)))
;; 	    ;; (font-lock-add-keywords
;; 	    ;;  'python-mode
;; 	    ;;  '(("\\(pdb.set_trace\\)" nil font-lock-warning-face t)));; custom-invalid t)))  ;; font-lock-warning-face t)))

;; 	    ;; (when (load "flycheck" t t)
;; 	    ;;   (setq flycheck-python-flake8-executable (concat (getenv "HOME") "/.pyenv/versions/elpy/bin/flake8"))
;; 	    ;;   ;(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;; 	    ;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

;; 	    ;; (local-set-key (kbd "C-.") 'xref-find-definitions)
;; 	    ;; (local-set-key (kbd "C->") 'elpy-goto-assignment)
;; 	    ;; (local-set-key (kbd "C-,") 'xref-pop-marker-stack)
;; 	    (set (make-local-variable 'indent-tabs-mode) nil)
;; 	    (set-variable 'py-indent-offset 4)
;; 	    (set-variable 'tab-width 4)
;; 	    (show-paren-mode 1)
;; 	    (column-number-mode)
;; 	    ;;(setenv "PYTHONPATH" "/Users/brendancox/watersmart/backend/lib:/Users/brendancox/watersmart/backend/mailing/bin:/Users/brendancox/watersmart/backend/data_loader_v2:/Users/brendancox/watersmart/statistics")
;; 	    ;;(setenv "PYTHONPATH" ".:/home/bcox/sauce/lib:/home/bcox/sauce/cloud")
;; 	    ;;
;; 	    ;; If deleting trailing whitespace for all files gets old, have a
;; 	    ;; helper function that only does it if the current buffer is python-mode
;; 	    (add-to-list 'before-save-hook 'delete-trailing-whitespace)
;; 	    (load-library "py")))
