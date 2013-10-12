(add-lib-path "flymake-cursor")
(require 'flymake-cursor)

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    ;; Make sure it's not a remote buffer or flymake would not work
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-with-folder-structure)) ;;'flymake-create-temp-in-system-tempdir))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      ;;(list "/usr/local/bin/pyflakes" (list temp-file))))
      (list "pyflakes" (list temp-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)

