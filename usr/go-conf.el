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

(use-package go-playground
  :ensure t)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook (lambda ()
			  (lsp-deferred)
			  (setq-local tab-width 4)
			  (lsp-go-install-save-hooks)
			  (bind-key "C-c M-." 'lsp-find-references)
			  ))
;;(add-hook 'go-mode-hook #'yas-minor-mode)
;;(add-hook 'go-mode-hook (lambda () (setq-local tab-width 4)))

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
