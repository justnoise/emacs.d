;----------------------------------------
; ORG Mode
;----------------------------------------
(defun goto-todo-list ()
  (interactive)
  (find-file "/Users/bcox/todo.org"))
(defun goto-notes ()
  (interactive)
  (find-file "/Users/bcox/notes.org"))
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-xt" 'goto-todo-list)
(global-set-key "\C-xn" 'goto-notes)
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only
;;(add-hook 'org-mode-hook 'transient-mark-mode 1)
