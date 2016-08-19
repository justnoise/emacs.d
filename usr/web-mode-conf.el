(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(eval-after-load "web-mode"
  '(add-to-list 'web-mode-content-types '("javascript" . "\\.js\\.erb\\'")))
