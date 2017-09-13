;; ensure that we have a unified way of loading this across systems
;; stolen from sam aaron's live-coding-emacs config

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
     ("\\.cs\\'" flymake-simple-make-init)
     ("\\.p[ml]\\'" flymake-perl-init)
     ("\\.php[345]?\\'" flymake-php-init)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
     ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
     ("\\.tex\\'" flymake-simple-tex-init)
     ("\\.idl\\'" flymake-simple-make-init))))
 '(org-structure-template-alist
   (quote
    (("s" "#+BEGIN_SRC ?

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
     ("I" "#+INCLUDE: %file ?" "<include file=%file markup=\"?\">"))))
 '(package-selected-packages
   (quote
    (flymake-go go-autocomplete go-mode flycheck yaml-mode which-key web-mode rvm robe puppet-mode pallet magit jedi-direx hexrgb haskell-mode flymake-ruby flx-ido find-file-in-repository expand-region exec-path-from-shell ag ace-jump-mode ac-inf-ruby)))
 '(python-fill-docstring-style (quote django))
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 50)
 '(recentf-mode t)
 '(robe-completing-read-func (quote ido-completing-read))
 '(safe-local-variable-values (quote ((test-case-name . admin\.test\.test_release))))
 '(sort-fold-case t t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(vcl-indent-level 4))

(setq debug-on-error nil)

(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :family "Inconsolata")))))
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
