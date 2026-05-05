(use-package rustic
  :ensure t
  :hook (rustic-mode . lsp)
  :config
  (setq rustic-format-on-save nil
        rustic-lsp-client 'lsp-mode)  ;; explicitly use lsp-mode
  :custom
  (rustic-cargo-use-last-stored-arguments t))

(setq lsp-rust-analyzer-server-command '("rustup" "run" "stable" "rust-analyzer"))
(setq lsp-rust-server 'rust-analyzer)
