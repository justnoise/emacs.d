(defun colon-smart-newline ()
  (interactive)
  (insert ":")
  (newline-and-indent))
(define-key global-map (kbd "C-;") 'colon-smart-newline)

(define-key global-map (kbd "C-:") 'comment-region)

(set-face-foreground 'font-lock-warning-face "yellow")
(set-face-background 'font-lock-warning-face "red")
(font-lock-add-keywords
      'python-mode
      '(("\\(pdb.set_trace()\\)" 1 font-lock-warning-face t)
	("\\(import pdb\\)" 1 font-lock-warning-face t)))

(defun py-skeleton ()
  (interactive)
  (insert "def main():\n    pass\n\nif __name__ == '__main__':\n    main()"))
