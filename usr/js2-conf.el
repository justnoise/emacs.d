;; consider setting up https://github.com/ananthakumaran/tide
;; also: https://www.reddit.com/r/emacs/comments/b9oxbm/lspmode_javascript/
(setq exec-path (append exec-path '("~/.nvm/versions/node/v11.12.0/bin")))
;; Disable lsp-ui flymake default integration
;; https://github.com/emacs-lsp/lsp-ui/issues/226
;;(use-package typescript-mode :ensure t)
(use-package js2-mode :ensure t)
(use-package eslint-fix
  :ensure t
)
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
;;(add-hook 'js2-mode-hook #'setup-tide-mode)
(add-hook 'js-mode-hook 'eslint-fix-auto-mode)
(add-hook 'typescript-mode-hook 'eslint-fix-auto-mode)
(setq js-indent-level 2)
;; configure javascript-tide checker to run after default javascript checker
;;(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
;; (use-package prettier-js
;;   :ensure t
;;   ;; :init
;;   ;; (add-hook 'js2-mode-hook 'prettier-js-mode)
;;   )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package eslint-fix
;;   :ensure t
;; )

;; (use-package js2-mode
;;   :ensure t
;;   :init
;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;   :config
;;   (setq js-indent-level 2)
;;   (setq fill-column 80)
;;   (add-to-list 'before-save-hook 'delete-trailing-whitespace)
;;   ;;(add-hook 'js-mode-hook 'prettier-js-mode)
;;   (add-hook 'js-mode-hook 'eslint-fix-auto-mode)
;;   (define-key js-mode-map (kbd "M-.") nil)
;;   :bind
;;   ("C-c C-l" . console-log)
;;   ("<f5>" . run-debugger)
;;   )

;; (use-package xref-js2
;;   :ensure t
;;   :hook (js2-mode . (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

;; (use-package indium
;;   :ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;(add-hook 'js2-mode-hook )

;; Consider using eslinting: https://github.com/eslint/eslint
;; (add-hook 'js2-mode-hook
;;           (lambda () (flycheck-select-checker "javascript-eslint")))

;; The Tern project is a JavaScript analyzer that can be used to improve the JavaScript integration with editors like Emacs.
;; (use-package tern
;;    :ensure t
;;    :init (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;;    :config
;;      (use-package company-tern
;;         :ensure t
;;         :init (add-to-list 'company-backends 'company-tern)))
