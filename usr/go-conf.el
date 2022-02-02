;; (depends-on "go-autocomplete")
;; (depends-on "go-complete")
;; (depends-on "go-guru")
;; (depends-on "go-mode")
;; (depends-on "go-playground")
;; (depends-on "go-snippets")
;; (depends-on "gotest")

;; Taken from here: https://gist.github.com/psanford/b5d2689ff1565ec7e46867245e3d2c76

(require 'exec-path-from-shell) ;; if not using the ELPA package
(exec-path-from-shell-initialize)
;(exec-path-from-shell-copy-env "PATH")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))
;(setenv "GOPATH" "/home/bcox/go")
;(setenv "GOFLAGS" "-mod=vendor")

;; https://emacs-lsp.github.io/lsp-mode/page/installation/
(use-package lsp-mode
  :ensure t
  ;; uncomment to enable gopls http debug server
  ;; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :commands (lsp lsp-deferred)
  :config (progn
            ;; use flycheck, not flymake
            (setq lsp-prefer-flymake nil)))

;; optional - provides fancy overlay information
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config (progn
            ;; disable inline documentation
            ;;(setq lsp-ui-sideline-enable nil)
            ;; disable showing docs on hover at the top of the window
            ;;(setq lsp-ui-doc-enable nil)
	    ))

(use-package company
  :ensure t
  :config (progn
            ;; don't add any dely before trying to complete thing being typed
            ;; the call/response to gopls is asynchronous so this should have little
            ;; to no affect on edit latency
            (setq company-idle-delay 0)
            ;; start completing after a single character instead of 3
            (setq company-minimum-prefix-length 1)
            ;; align fields in completions
            (setq company-tooltip-align-annotations t)
            ))

(use-package go-playground
  :ensure t)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(defun insert-test ()
  (interactive)
  (insert "func Test(t *testing.T) {\n\n}")
  (backward-char 19))

(defun insert-test-case ()
  (interactive)
  (insert "func Test(t *testing.T) {
\ttests := []struct {
\t\t
\t}{
\t}
\tfor _, tc := range tests {
\t}
}
")
  (backward-char 81))



;; (add-to-list 'load-path "/home/you/somewhere/emacs/")
;; (require 'go-mode-load)
