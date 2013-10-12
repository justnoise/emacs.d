;; autocomplete
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (global-auto-complete-mode t) 

;;(add-lib-path "auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete/dict")
(set-default 'ac-sources
             '(ac-source-jedi-direct
	       ac-source-abbrev
               ac-source-dictionary))
(ac-config-default)
(global-auto-complete-mode t)
(dolist (mode '(python-mode ))
  (add-to-list 'ac-modes mode))
;(ac-flyspell-workaround)


;; (add-to-list 'ac-dictionary-directories (concat dotfiles-lib-dir "auto-complete/dict"))


;; ;; don't use comphist since it re-orders what I actually want
;; (setq ac-use-comphist nil)
;; ;;include this once we have a temp directory defined
;; ;;(setq ac-comphist-file (concat dotfiles-tmp-dir "ac-comphist.dat"))

;(setq ac-auto-show-menu 1)  ;; set to nil to turn it off
;(setq ac-dwim t)
;;(setq ac-use-menu-map t)
;;(setq ac-quick-help-delay 2)
;(setq ac-quick-help-height 60)
;(setq ac-menu-height 15)

;; (setq ac-auto-start nil)  ;; turn off displaying of menu automatically
;;(setq ac-use-fuzzy t)



;; (set-default 'ac-sources
;;              '(ac-source-jedi-direct))
	       ;; ac-source-abbrev
               ;; ac-source-words-in-buffer
               ;; ac-source-words-in-same-mode-buffers
               ;; ac-source-words-in-all-buffer
               ;; ;;ac-source-semantic
               ;; ac-source-dictionary))

;;(dolist (mode '(org-mode text-mode csv-mode html-mode nxml-mode sh-mode clojure-mode lisp-mode ))


;; ;; ;;ac-slime auto-complete plugin
;; ;; (add-live-lib-path "ac-slime")
;; ;; (require 'ac-slime)
;; ;; (add-hook 'slime-mode-hook 'set-up-slime-ac)
;; ;; (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; ;;Key triggers
;; (ac-set-trigger-key "TAB")
;; ;;(define-key ac-completing-map (kbd "C-M-n") 'ac-next)
;; ;;(define-key ac-completing-map (kbd "C-M-p") 'ac-previous)
;; ;;(define-key ac-completing-map "\t" 'ac-complete)
;; ;;(define-key ac-completing-map "\r" nil)
