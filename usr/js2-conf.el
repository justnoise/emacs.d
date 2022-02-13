;; consider setting up https://github.com/ananthakumaran/tide
;; also: https://www.reddit.com/r/emacs/comments/b9oxbm/lspmode_javascript/

(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

(define-key js-mode-map (kbd "M-.") nil)

(use-package xref-js2
  :ensure t
  :hook (js2-mode . (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

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
