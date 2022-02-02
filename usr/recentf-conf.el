(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

(use-package recentf
  :commands (recentf-mode)
  :ensure t
  :config (setq recentf-max-saved-items 100)
  :bind (("C-x C-r" . ido-recentf-open)))

 
