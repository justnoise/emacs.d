(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t) ; this doesn't seem to work...
  (setq use-package-expand-minimally t))

;;; -------------------- PACKAGES --------------------

(use-package which-key
  :ensure t
  :config (which-key-mode))
(use-package hcl-mode :ensure t)
(use-package terraform-mode :ensure t)
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :defer nil
  :config
  (exec-path-from-shell-initialize))
(use-package yaml-mode
  :ensure t
  :mode (("\\.yml$\\'" . yaml-mode) ("\\.yaml$\\'" . yaml-mode)))
(use-package markdown-mode
  :ensure t)
(use-package ag
  :ensure t
  :bind (("\C-xp" . ag-project)
	 ("\C-xa" . ag)))
(use-package flycheck
  :ensure t)
(add-hook 'after-init-hook #'global-flycheck-mode)
(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)
   ("C-c C-c M-x" . execute-extended-command)))
