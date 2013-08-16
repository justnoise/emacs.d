;----------------------------------------
; Cedet
;----------------------------------------
;; ;; todo, figure out how to do this idiomatically
(load-file (concat dotfiles-lib-dir "cedet/common/cedet.el"))
;; ;; not sure if this is needed
;; (global-ede-mode t)
;; (semantic-load-enable-gaudy-code-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;; ; todo, add in local copy of boost
;; ;;(semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)

;;(require 'semantic)
(semantic-load-enable-gaudy-code-helpers)
;;(semantic-load-enable-code-helpers)
;;(semantic-idle-completion-mode)
;;(semantic-load-enable-semantic-debugging-helpers)

(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
;;(global-srecode-minor-mode 1)
;;(global-semantic-mru-bookmark-mode 1)

;;don't really need this since it's all stored in ~/.semandicdb
;;(setq semanticdb-default-save-directory (concat dotfiles-tmp-dir "semantic.cache"))

(require 'semantic-decorate-include)

;; gcc setup
(require 'semantic-gcc)

;; smart complitions
(require 'semantic-ia)

(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

(require 'eassist)

;; ;; customisation of modes
(defun bcox/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  )

(add-hook 'semantic-init-hooks 'bcox/cedet-hook)
(add-hook 'c-mode-common-hook 'bcox/cedet-hook)
(add-hook 'lisp-mode-hook 'bcox/cedet-hook)
(add-hook 'scheme-mode-hook 'bcox/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'bcox/cedet-hook)
;;(add-hook 'c++-mode (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))
;; (add-hook 'erlang-mode-hook 'bcox/cedet-hook)

(defun bcox/c-mode-cedet-hook ()
 ;; (local-set-key "." 'semantic-complete-self-insert)
 ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)
  )
(add-hook 'c-mode-common-hook 'bcox/c-mode-cedet-hook)

;; hooks, specific for semantic
(defun bcox/semantic-hook ()
;; (semantic-tag-folding-mode 1)
  (imenu-add-to-menubar "TAGS")
 )
(add-hook 'semantic-init-hooks 'bcox/semantic-hook)

;; (custom-set-variables
;;  '(semantic-idle-scheduler-idle-time 3)
;;  '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;;  '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;; (global-semantic-folding-mode 1)
(custom-set-variables
 '(semantic-idle-scheduler-idle-time 3)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point)))))

;; gnu global support
(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
 
;; ctags
;(require 'semanticdb-ectag)
;(semantic-load-enable-primary-exuberent-ctags-support)



;; gnu global support
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; ctags
;;(require 'semanticdb-ectag)
;;(semantic-load-enable-primary-exuberent-ctags-support)

;;
;;(semantic-add-system-include "/usr/local/include/boost_1_37_0/" 'c++-mode)
;;(semantic-add-system-include "~/exp/include" 'c-mode)

;; (defun recur-list-files (dir re)
;;   "Returns list of files in directory matching to given regex"
;;   (when (file-accessible-directory-p dir)
;;     (let ((files (directory-files dir t))
;;           matched)
;;       (dolist (file files matched)
;;         (let ((fname (file-name-nondirectory file)))
;;           (cond
;;            ((or (string= fname ".")
;;                 (string= fname "..")) nil)
;;            ((and (file-regular-p file)
;;                  (string-match re fname))
;;             (setq matched (cons file matched)))
;;            ((file-directory-p file)
;;             (let ((tfiles (recur-list-files file re)))
;;               (when tfiles (setq matched (append matched tfiles)))))))))))

;; (defun c++-setup-boost (boost-root)
;;   (when (file-accessible-directory-p boost-root)
;;     (let ((cfiles (recur-list-files boost-root "\\(config\\|user\\)\\.hpp")))
;;       (dolist (file cfiles)
;;         (add-to-list 'semantic-lex-c-preprocessor-symbol-file file)))))


;;
;;(global-semantic-idle-tag-highlight-mode 1)

;;; ede customization
(require 'semantic-lex-spp)
(global-ede-mode t)
(ede-enable-generic-projects)
