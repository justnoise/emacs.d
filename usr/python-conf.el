;;----------------------------------------
;; Python
;;----------------------------------------




;; Much of this install/update came from the wise words here:
;; https://smythp.com/emacs/python/2016/04/27/pyenv-elpy.html
;;
;; Prereqs: sudo apt-get install --no-install-recommends git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
;; 1. pyenv
;; 2. pyenv-virtualenv plugin (came installed already)
;; 3. M-x package-install RET pyenv-mode
;; 4. M-x elpy-config

;; workflow
;; cd <gitdir>
;; pyenv install <python_version>
;; pyenv local <env name>



;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))
;; (delete `elpy-module-highlight-indentation elpy-modules)
;; (setq elpy-rpc-backend "jedi")

;; ;; ;; check which version is running: M-x elpy-config
;; ;; ;; set the mode with M-x pyenv-mode-set

;; (defvar font-lock-debug-face
;;   'font-lock-format-specifier-face
;;   "Face name to use for format specifiers.")

;; (defface font-lock-debug-face
;;   '((t (:foreground "OrangeRed1")))
;;   "Font Lock mode face used to highlight format specifiers."
;;   :group 'font-lock-faces)


;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (setenv "WORKON_HOME" (concat (getenv "HOME") "/.virtualenvs"))
;; 	    ;; (font-lock-add-keywords
;; 	    ;;       'python-mode
;; 	    ;;       '(("\\(^\\ *pdb.set_trace\\)" 1 font-lock-warning-face t)))

;; 	    ;; (font-lock-add-keywords
;; 	    ;;  'python-mode
;; 	    ;;  '(("\\<\\(pdb.set_trace\\)\\>" nil font-lock-warning-face t)))
;; 	    ;; (font-lock-add-keywords
;; 	    ;;  'python-mode
;; 	    ;;  '(("\\(pdb.set_trace\\)" nil font-lock-warning-face t)));; custom-invalid t)))  ;; font-lock-warning-face t)))
;; 	    (when (load "flycheck" t t)
;; 	      (setq flycheck-python-flake8-executable (concat (getenv "HOME") "/.pyenv/versions/elpy/bin/flake8"))
;; 	      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;; 	      (add-hook 'elpy-mode-hook 'flycheck-mode))

;; 	    (local-set-key (kbd "C-.") 'xref-find-definitions)
;; 	    (local-set-key (kbd "C->") 'elpy-goto-assignment)
;; 	    (local-set-key (kbd "C-,") 'xref-pop-marker-stack)
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
