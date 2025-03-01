(add-hook 'prog-mode-hook 'copilot-mode)
(setq copilot-node-executable "/Users/bcox/.nvm/versions/node/v18.19.0/bin/node")

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(setq copilot-idle-delay 0.75)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C->") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "C-<") 'copilot-previous-completion)
