;jedi
(setq jedi:server-args
      '("--sys-path" "/Users/bcox/sauce/lib"
        "--sys-path" "/Users/bcox/sauce/cloud"
	"--sys-path" "/Users/bcox/sauce"
	"--virtual-env" "/Users/bcox/.virtualenvs/sauce"))
;; (setq jedi:server-args
;;       '("--virtual-env" "sauce"))
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:setup)
;hooks
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (jedi:setup)))


;; (setq jedi:setup-keys t)                      ; optional
;; (setq jedi:complete-on-dot t)                 ; optional
;; (message "loading jedi mode")
;; ;;Jedi
;; (setq jedi:setup-keys t)
;; ;;(setq jedi:complete-on-dot t)
;; (add-hook 'python-mode-hook 'auto-complete-mode)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; ;(add-hook 'python-mode-hook 'jedi:ac-setup)
;; ;(setq jedi:tooltip-method '(popup))



;(autoload 'jedi:setup "jedi" nil t)

;;


