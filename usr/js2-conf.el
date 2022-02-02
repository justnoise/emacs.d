(use-package js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

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
