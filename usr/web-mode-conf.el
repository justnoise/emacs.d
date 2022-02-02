(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
	 ("\\.html?\\'" . web-mode))
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2))
;; (require 'web-mode)
;; ;; (add-to-list 'auto-mode-alist '
;; ;; (add-to-list 'auto-mode-alist '
;; (setq web-mode-markup-indent-offset 2)
;; (setq web-mode-css-indent-offset 2)
;; (setq web-mode-code-indent-offset 2)
;; (setq web-mode-attr-indent-offset 2)
;; ;; (eval-after-load "web-mode"
;; ;;   ;; '(add-to-list 'web-mode-content-types '("javascript" . "\\.js\\.erb\\'"))
;; ;;   )
