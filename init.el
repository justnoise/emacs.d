;; ensure that we have a unified way of loading this across systems
;; stolen from sam aaron's live-coding-emacs config
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq dotfiles-lib-dir (concat dotfiles-dir "lib/"))
(setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))
(setq dotfiles-etc-dir (concat dotfiles-dir "etc/"))
(setq dotfiles-tmp-dir (concat dotfiles-dir "tmp/"))

(defun add-dotfile-path (p)
  (add-to-list 'load-path (concat dotfiles-dir p)))

(defun add-lib-path (p)
  (add-to-list 'load-path (concat dotfiles-lib-dir p)))

(defun load-dotfile (f)
  (load-file (concat dotfiles-dir f)))

(add-dotfile-path "lib")

(load-dotfile "usr/usr.el")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-macro-cppflags "-I \"/usr/local/include/boost_1_37_0\"")
 '(completion-ignored-extensions (quote (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".dvi" ".fmt" ".tfm" ".pdf" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo")))
 '(indent-tabs-mode nil)
 '(js2-mirror-mode nil)
 '(mumamo-chunk-coloring 255)
 '(recentf-keep-non-readable-files-p t nil (recentf))
 '(safe-local-variable-values (quote ((Syntax . Common-Lisp))))
 '(semantic-idle-scheduler-idle-time 3)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tab-width 2)
 '(x-select-enable-clipboard t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-warning-face ((t (:background "red" :foreground "blue")))))

(setq debug-on-error nil)

(put 'narrow-to-region 'disabled nil)
