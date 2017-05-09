;
; functions:
; kill current identifier
; go to char in line (forwards and backwards)
; go to next open parenthesis
; go to next close parenthesis
; have emacs automatically connect to a mysql db

(when (eq system-type 'darwin) ;; mac specific settings
;  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (add-to-list 'exec-path "/usr/local/bin")
  (add-to-list 'exec-path "/Users/bcox/go/bin")
  (add-to-list 'exec-path "/Users/bcox/bin")
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  (custom-set-faces
   '(default ((t (:height 140 :family "Inconsolata")))))
  )

(setq magit-last-seen-setup-instructions "1.4.0")
;; create a var for this directory
(setq usr-config-dir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(defun load-usr-config-file (f)
  (load-file (concat usr-config-dir f)))

(add-lib-path "lisp")

(when (>= emacs-major-version 24)
      (load-usr-config-file "packages-conf.el")
      ;(load-usr-config-file "auto-complete-conf.el")
      (load-usr-config-file "color-theme-conf.el"))

(load-usr-config-file "pallet-conf.el") ;PUT THIS FIRST!

(load-usr-config-file "utils.el")
(load-usr-config-file "fractals.el")
(load-usr-config-file "ido-conf.el")
(load-usr-config-file "ace-jump-conf.el")
(load-usr-config-file "smex-conf.el")
(load-usr-config-file "yaml-conf.el")
(load-usr-config-file "recentf-conf.el")
;;(load-usr-config-file "flymake-conf.el")
(add-hook 'after-init-hook #'global-flycheck-mode)
(load-usr-config-file "go-conf.el")
(load-usr-config-file "python-conf.el")
(load-usr-config-file "ruby-conf.el")
(load-usr-config-file "puppet-conf.el")
; if we're on a mac, load jedi cause it'll be installed
(if (window-system)
    (load-usr-config-file "jedi-conf.el"))
(load-usr-config-file "haskell-conf.el")
(load-usr-config-file "web-mode-conf.el")

(load-usr-config-file "org-mode-conf.el")
(load-usr-config-file "magit-conf.el")
(require 'which-key)
(which-key-mode)
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)



(require 'vcl-mode)
;(load-usr-config-file "elixir-conf.el")
;(load-usr-config-file "column-marker.el")
;(load-usr-config-file "erlang-conf.el")
;(load-usr-config-file "ipython-conf.el")

;; Tried to get zsh to play nice with my emacs install... it no work
;; (require 'multi-term)
;; (setq multi-term-program "/usr/local/bin/zsh")
;; (setq system-uses-terminfo nil)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

(require 'find-file-in-repository)
(global-set-key [f7] 'find-file-in-repository)

(require 'windmove)
(windmove-default-keybindings 'shift)
(setq split-height-threshold 1600)
(setq split-width-threshold 800)


;; (load-usr-config-file "paredit-conf.el")
;; (load-usr-config-file "cpp-conf.el")
(load-usr-config-file "c-conf.el")
;;(load-usr-config-file "cedet-conf.el")


;(load-usr-config-file "js2-conf.el")
;(add-lib-path "undo-tree")
;(require 'undo-tree)
;;(global-undo-tree-mode)

;; (defun load-cedet ()
;;   (interactive)
;;   (load-usr-config-file "cedet-conf.el"))

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
;; put misc stuff in here
;; (when window-system
;;   (set-frame-position (selected-frame) 75 29)
;;   (set-frame-size (selected-frame) 98 60)
;;   (if (eq system-type 'windows-nt)
;;       (add-to-list 'default-frame-alist '(font . "-outline-Consolas-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1"))
;;     (add-to-list 'default-frame-alist '(font . "-b&h-lucidatypewriter-medium-r-normal-sans-12-120-75-75-m-70-iso8859-1"))
;;     ))


(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; todo, source from zshrc and use sed
(if (not (getenv "TERM_PROGRAM"))
    (setenv "PATH"
	    (shell-command-to-string "source $HOME/.bashrc && printf $PATH")))

; ideas for future improvement

;; (push '("." . "~/.emacs_backups") backup-directory-alist)
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

;remove the useless toolbar from the top of the screen
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\M-`" 'other-frame)
(global-set-key "\C-xp" 'ag-project)
(global-set-key "\C-xa" 'ag)
(defalias 'qrr 'query-replace-regexp)
;(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
;(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Shell colors
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)



; ----------------------------------------
; PHP stuff
; ----------------------------------------
;(load-usr-config-file "php-conf.el")

;----------------------------------------
; Version Control - turn this off because it's very slow over sshfs
;----------------------------------------
(setq vc-handled-backends nil)

(defun cvs-edit ()
  (interactive)
  ;;first get whether we're on ny or est then remove full path and
  ;;replace with sandbox.
  (let ((host (nth 3 (split-string (buffer-file-name) "/")))
        (buffer-path (replace-regexp-in-string "/home/bcox/\\(ny\\|est\\|fund\\)/sandbox/" "" (buffer-file-name))))
    (let ((command (concat "ssh " host " 'cd /home/bcox/sandbox; cvs edit " buffer-path "'")))
      (shell-command command)
      (setq buffer-read-only nil)
      (print command))))


;; ----------------------------------------
;; KBD Macros
(fset 'securities-to-dict
   "\C-e : \C-k\C-k\C-k\240'\C-e',\C-n\C-a\C-k")
