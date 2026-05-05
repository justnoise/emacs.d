;; https://emacs-lsp.github.io/lsp-mode/page/installation/
;; https://ianyepan.github.io/posts/emacs-ide/
(use-package lsp-mode
  :ensure t
  ;; uncomment to enable gopls http debug server
  ;; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :hook ((c++-mode
          python-mode
          java-mode
          go-mode
          rustic-mode
          js2-mode
          typescript-mode) . lsp-deferred)  
  ; :commands (lsp lsp-deferred)
  :config
  (setq lsp-disabled-clients '(eslint)) ;; note: must be a list
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-file-watchers nil))
  ;; :config (progn
  ;;           ;; use flycheck, not flymake
  ;; 	    ;;(require 'lsp-clients)
  ;; 	    (setq lsp-disabled-clients "eslint")
  ;; 	    (add-hook 'js2-mode-hook 'lsp)
  ;;           (setq lsp-prefer-flymake nil)))

(setq treesit-font-lock-level 4)


;; optional - provides fancy overlay information
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-diagnostic-max-lines 10)
  ;; Uncomment these if you prefer less visual noise:
  ;; (setq lsp-ui-sideline-enable nil)
  ;; (setq lsp-ui-doc-enable nil)
  )
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :config
;;   (setq lsp-ui-sideline-diagnostic-max-lines 10)
;;   ;; disable inline documentation
;;   ;; (setq lsp-ui-sideline-enable nil)
;;   ;; disable showing docs on hover at the top of the window
;;   ;; (setq lsp-ui-doc-enable nil)
;;   ;; (setq lsp-ui-doc-header t)
;;   ;; (setq lsp-ui-doc-include-signature t)
;;   ;; (setq lsp-ui-doc-border (face-foreground 'default))
;;   ;; (setq lsp-ui-sideline-show-code-actions t)
;;   ;; (setq lsp-ui-sideline-delay 0.05))
;;   )
;; autocompletion
(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t))

;; (use-package company
;;   :ensure t
;;   :config (progn
;;             ;; don't add any dely before trying to complete thing being typed
;;             ;; the call/response to gopls is asynchronous so this should have little
;;             ;; to no affect on edit latency
;;             (setq company-idle-delay 0)
;;             ;; start completing after a single character instead of 3
;;             (setq company-minimum-prefix-length 1)
;;             ;; align fields in completions
;;             (setq company-tooltip-align-annotations t)
;;             ))
