;; ensure that we have a unified way of loading this across systems
;; stolen from sam aaron's live-coding-emacs config
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq dotfiles-lib-dir (concat dotfiles-dir "lib/"))
(setq dotfiles-pkg-dir (concat dotfiles-dir "elpa/"))
(setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))
(setq dotfiles-etc-dir (concat dotfiles-dir "etc/"))
(setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))

(defun add-dotfile-path (p)
  (add-to-list 'load-path (concat dotfiles-dir p)))

(defun add-lib-path (p)
  (add-to-list 'load-path (concat dotfiles-lib-dir p)))

(defun add-pkg-path (p)
 (add-to-list 'load-path (concat dotfiles-pkg-dir p)))

(defun load-dotfile (f)
  (load-file (concat dotfiles-dir f)))

(add-dotfile-path "lib")

(load-dotfile "usr/usr.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (zenburn)))
 '(flymake-allowed-file-name-masks
   (quote
    (("\\.py\\'" flymake-pyflakes-init)
     ("\\.html?\\'" flymake-xml-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.p[ml]\\'" flymake-perl-init)
     ("\\.php[345]?\\'" flymake-php-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init))))
 '(python-fill-docstring-style (quote django))
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 50)
 '(recentf-mode t)
 '(safe-local-variable-values
   (quote
    ((test-case-name . twisted\.conch\.test\.test_endpoints)
     (test-case-name . twisted\.web\.test\.test_http)
     (test-case-name . twisted\.python\.test\.test_deprecate)
     (test-case-name . flocker\.node\.agents\.functional\.test_gce)
     (test-case-name . flocker\.node\.agents\.functional\.test_ebs)
     (test-case-name . flocker\.node\.agents\.functional\.test_pd)
     (test-case-name . twisted\.python\.test\.test_reflectpy3)
     (test-case-name . twisted\.test\.test_reflect)
     (test-case-name . admin\.test\.test_packaging)
     (test-case-name . twisted\.trial\.test)
     (test-case-name . flocker\.node\.agents\.test\.test_blockdevice)
     (test-case-name . twisted\.test\.test_paths)
     (test-case-name . twisted\.python\.test\.test_constants)
     (test-case-name . flocker\.node\.agents\.test\.test_blockdevice_manager))))
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

(setq debug-on-error nil)

(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :family "Inconsolata")))))
