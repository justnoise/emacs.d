;(add-lib-path "recentf")
(require 'recentf)

;; enable recent files mode.
(recentf-mode t)

(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
 
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)
 
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))
