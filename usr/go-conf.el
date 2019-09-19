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
(setenv "GOPATH" "/home/bcox/go")

(add-hook 'go-mode-hook
	  (lambda ()
	    (set-variable 'c-basic-offset 4)
	    (set-variable 'tab-width 4)
	    (setq gofmt-command "goimports")
	    (add-to-list 'exec-path "/usr/local/go/bin/gofmt")
	    (add-hook 'before-save-hook 'gofmt-before-save)
	    (local-set-key (kbd "C-.") 'godef-jump)
	    (local-set-key (kbd "C-,") 'pop-tag-mark)
	    (auto-complete-mode 1)

	    (if (not (string-match "go" compile-command))
		(set (make-local-variable 'compile-command)
		     "go build -v && go test -v && go vet"))
	    ))
(with-eval-after-load 'go-mode
  (require 'go-autocomplete)
  (require 'go-guru)
  )




;; (add-to-list 'load-path "/home/you/somewhere/emacs/")
;; (require 'go-mode-load)
