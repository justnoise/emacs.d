;; (eval-when-compile
;;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
;;   (add-to-list 'load-path "<path where use-package is installed>")
;;   (require 'use-package));


(setq magit-last-seen-setup-instructions "1.4.0")
;; create a var for this directory
(setq usr-config-dir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(defun load-usr-config-file (f)
  (load-file (concat usr-config-dir f)))

(add-lib-path "lisp")
(load-usr-config-file "packages-conf.el")
(load-usr-config-file "color-theme-conf.el")
(load-usr-config-file "projectile-conf.el")
(load-usr-config-file "utils.el")
(load-usr-config-file "fractals.el")
(load-usr-config-file "ido-conf.el")
(load-usr-config-file "avy-conf.el")
(load-usr-config-file "recentf-conf.el")
(load-usr-config-file "lsp-conf.el")
(load-usr-config-file "go-conf.el")
(load-usr-config-file "js2-conf.el")
(load-usr-config-file "python-lsp-conf.el")
(load-usr-config-file "web-mode-conf.el")
(load-usr-config-file "org-mode-conf.el")
(load-usr-config-file "magit-conf.el")
(load-usr-config-file "protobuf-conf.el")
(load-usr-config-file "cpp-conf.el")
(load-usr-config-file "c-conf.el")

;; (require 'expand-region)
;; (global-set-key (kbd "C-=") 'er/expand-region)
;;(load-usr-config-file "ace-jump-conf.el")
;(load-usr-config-file "flymake-conf.el")
;(load-usr-config-file "python-conf.el")
;(load-usr-config-file "ruby-conf.el")
;(load-usr-config-file "puppet-conf.el")
;if we're on a mac, load jedi cause it'll be installed
;; (if (window-system)
;;     (load-usr-config-file "jedi-conf.el"))
;(load-usr-config-file "haskell-conf.el")
;(load-usr-config-file "erlang-conf.el")
;(load-usr-config-file "elm-conf.el")
;(load-usr-config-file "elixir-conf.el")
;(load-usr-config-file "column-marker.el")
;(load-usr-config-file "ipython-conf.el")

(require 'windmove)
(windmove-default-keybindings 'shift)
(setq split-height-threshold 1600)
(setq split-width-threshold 800)

(when (eq system-type 'darwin) ;; mac specific settings
;  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (add-to-list 'exec-path "/usr/local/bin")
  (let ((homedir (concat (getenv "HOME") "/")))
    (add-to-list 'exec-path (concat homedir "go/bin"))
    (add-to-list 'exec-path (concat homedir "bin")))
    ;(add-to-list 'exec-path (concat homedir"/Users/brendancox/Development/go/bin/godef")
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (set-face-font 'default "-*-Inconsolata-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
  ;; (custom-set-faces
  ;;  '(default ((t (:height 130 :family "Inconsolata")))))
  )

(defun turn-off-indent-tabs-mode ()
  (setq indent-tabs-mode nil))
(add-hook 'sh-mode-hook #'turn-off-indent-tabs-mode)

(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-dabbrev-all-buffers
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))

(eval-after-load "dabbrev" '(defalias 'dabbrev-expand 'hippie-expand))
;----------------------------------------
;; todo, source from zshrc and use sed
;; (if (not (getenv "TERM_PROGRAM"))
;;     (setenv "PATH"
;; 	    (shell-command-to-string "source $HOME/.bashrc && printf $PATH")))

(setq backup-directory-alist
      `((".*" . "~/.emacs_backups")))
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs_backups" t)))
(setq inhibit-splash-screen t)
(setq transient-mark-mode nil)
(setq auto-save-interval 600)

;(setq font-lock-maximum-decoration 3)
;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\M-`" 'other-frame)
(global-set-key "\M-g" 'goto-line)
(defalias 'qrr 'query-replace-regexp)

;; Shell colors
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(delete-other-windows)
(big-print)
