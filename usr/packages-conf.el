;; (custom-set-variables
;;  '(gnutls-algorithm-priority "normal:-vers-tls1.3"))

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


(use-package which-key :ensure t)
(which-key-mode)
(use-package hcl-mode :ensure t)
(use-package terraform-mode :ensure t)
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))
(use-package find-file-in-repository
  :ensure t
  :defer nil
  :bind ("<f7>" . find-file-in-repository))
(use-package markdown-mode
  :ensure t)

;; (require 'package)
;; (add-to-list 'package-archives
;;     '("marmalade" .
;;       "https://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/") t)
;; ;(package-initialize)
