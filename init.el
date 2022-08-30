;; ensure that we have a unified way of loading this across systems
;; stolen from sam aaron's live-coding-emacs config

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(setq warning-minimum-level :emergency)

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
 '(ag-arguments
   '("--smart-case" "--stats" "--ignore" "vendor/" "--ignore" "initial_load/" "-W" "1000"))
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("646676b902afda86f22bc66a2e14dbae7c0fc2fc988cc2fc11099ef5684b7a78" default))
 '(elpy-rpc-timeout 10)
 '(elpy-rpc-virtualenv-path (concat (getenv "HOME") "/.pyenv/versions/elpy"))
 '(fci-rule-color "#383838")
 '(flycheck-check-syntax-automatically '(save))
 '(flycheck-disabled-checkers '(go-golint))
 '(flymake-proc-allowed-file-name-masks
   '(("\\.py\\'" flymake-pyflakes-init)
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.p[ml]\\'" flymake-perl-init)
     ("\\.php[345]?\\'" flymake-php-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init)))
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(groovy-indent-offset 2)
 '(org-structure-template-alist
   '(("s" "#+BEGIN_SRC ?

#+END_SRC" "<src lang=\"?\">

</src>")
     ("e" "#+BEGIN_EXAMPLE
?
#+END_EXAMPLE" "<example>
?
</example>")
     ("q" "#+BEGIN_QUOTE
?
#+END_QUOTE" "<quote>
?
</quote>")
     ("v" "#+BEGIN_VERSE
?
#+END_VERSE" "<verse>
?
</verse>")
     ("V" "#+BEGIN_VERBATIM
?
#+END_VERBATIM" "<verbatim>
?
</verbatim>")
     ("c" "#+BEGIN_CENTER
?
#+END_CENTER" "<center>
?
</center>")
     ("r" "#+BEGIN_Ruby
?
#+END_Ruby" "<literal style=\"ruby\">
?
</literal>")
     ("p" "#+BEGIN_Python
?
#+END_Python" "<literal style=\"python\">
?
</literal>")
     ("l" "#+BEGIN_LaTeX
?
#+END_LaTeX" "<literal style=\"latex\">
?
</literal>")
     ("L" "#+LaTeX: " "<literal style=\"latex\">?</literal>")
     ("h" "#+BEGIN_HTML
?
#+END_HTML" "<literal style=\"html\">
?
</literal>")
     ("H" "#+HTML: " "<literal style=\"html\">?</literal>")
     ("a" "#+BEGIN_ASCII
?
#+END_ASCII" "")
     ("A" "#+ASCII: " "")
     ("i" "#+INDEX: ?" "#+INDEX: ?")
     ("I" "#+INCLUDE: %file ?" "<include file=%file markup=\"?\">")))
 '(package-selected-packages
   '(tide lua-mode indium bazel eslint-fix prettier-js projectile xref-js2 js2-mode avy vcl-mode go-complete php-mode pyenv-mode-auto pyenv-mode use-package async cask elm-mode f flx git-commit gotest hcl-mode inf-ruby jedi jedi-core magit-popup package-build reformatter transient with-editor dash go-snippets yasnippet groovy-mode terraform-mode go-guru go-playground erlang ## protobuf-mode flymake-go go-autocomplete go-mode flycheck yaml-mode which-key web-mode rvm robe puppet-mode pallet magit jedi-direx hexrgb haskell-mode flymake-ruby flx-ido find-file-in-repository expand-region exec-path-from-shell ag ace-jump-mode ac-inf-ruby))
 '(python-fill-docstring-style 'django)
 '(recentf-auto-cleanup 'never)
 '(recentf-max-saved-items 50)
 '(recentf-mode t)
 '(robe-completing-read-func 'ido-completing-read)
 '(safe-local-variable-values '((test-case-name . admin\.test\.test_release)))
 '(sort-fold-case t t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(vcl-indent-level 4)
 '(xref-js2-ignored-dirs '("bower_components" "build")))

(setq debug-on-error nil)

(put 'narrow-to-region 'disabled nil)
;; when eyes are better:
;'(default ((t (:height 135 :family "Inconsolata")))))
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 160 :family "Inconsolata")))))
