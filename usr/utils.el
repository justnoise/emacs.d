(defun camel-to-underscore (start end)
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (while (search-forward-regexp "\\([^_ ]\\)\\([A-Z]\\)" nil t)
        (let ((letter (downcase (match-string 2))))
          (replace-match (concat "\\1_" letter) t))))
    (downcase-region (point-min) (point-max))))
;;        (let ((letter (downcase (match-data 2))))
;;          (replace-match (concat "\\1_" letter))))))

(defun create-diary ()
  (interactive)
  (let ((todays-date (format-time-string "%Y%m%d.txt"))
	(home-dir (format "%s/" (getenv "HOME"))))
    (find-file (concat home-dir "/diary/" todays-date))))

(defun make-note (notename)
  (interactive "sName of note:")
  (let ((home-dir (format "%s/" (getenv "HOME"))))
    (find-file (concat home-dir "/notes/" notename))))

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(global-set-key (quote [f7]) 'switch-to-last-buffer)

(defun open-directory (dir)
  (interactive "DDirectory: ")
  (when (eq system-type 'darwin)
    (if (eq (substring dir 0 1) "~")
	(setq dir (concat "/Users/bcox" (substring dir 1))))
    (call-process "/usr/bin/open" nil nil nil "")))

; == custom movement ==
(defun next-line-center ()
  (interactive)
  (forward-line 1)
  (recenter))
(defun previous-line-center ()
  (interactive)
  (forward-line -1)
  (recenter))
(global-set-key "\C-\M-j" 'next-line-center)
(global-set-key "\C-\M-k" 'previous-line-center)

(defun open-next-line (arg)
  "Move to the next line and then opens a line.
 See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'open-next-line)

;; behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one.

  See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key (kbd "M-o") 'open-previous-line)

;; autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

; == buffer transpose/swap ==
(setq swapping-buffer nil)
(setq swapping-window nil)
(defun swap-buffers-in-windows ()
  "Swap buffers between two windows"
  (interactive)
  (if (and swapping-window
           swapping-buffer)
      (let ((this-buffer (current-buffer))
            (this-window (selected-window)))
        (if (and (window-live-p swapping-window)
                 (buffer-live-p swapping-buffer))
            (progn (switch-to-buffer swapping-buffer)
                   (select-window swapping-window)
                   (switch-to-buffer this-buffer)
                   (select-window this-window)
                   (message "Swapped buffers."))
          (message "Old buffer/window killed.  Aborting."))
        (setq swapping-buffer nil)
        (setq swapping-window nil))
    (progn
      (setq swapping-buffer (current-buffer))
      (setq swapping-window (selected-window))
      (message "Buffer and window marked for swapping."))))
(global-set-key "\M-s" 'swap-buffers-in-windows)

(defun set-tabwidth (val)
  (interactive "nNew C tab offset: ")
  (set-variable 'tab-width val))

(defun correct-indenting ()
  (interactive)
  (set-variable 'tab-width 8))

(defun set-indent (val)
  (interactive "nNew C tab offset: ")
  (setq c-basic-offset val)
  (set-variable 'tab-width val))


;Set the frame to open at the top of the screen and fill screen vertically
;; (defun maximize ()
;;   (interactive)
;;   (set-frame-position (selected-frame) 1 29)
;;   (set-frame-size (selected-frame) 270 77))
(defun make-big-work ()
  (interactive)
  (set-frame-position (selected-frame) 1800 1)
  (set-frame-size (selected-frame) 310 86))
(defun make-big-home ()
  (interactive)
  (set-frame-position (selected-frame) 1550 1)
  (set-frame-size (selected-frame) 254 71))
;; (defun make-big-home ()
;;   (interactive)
;;   (set-frame-position (selected-frame) 1440 1)
;;   (set-frame-size (selected-frame) 250 75))
(defun make-small ()
  (interactive)
  (set-frame-position (selected-frame) 25 25)
  (set-frame-size (selected-frame) 80 40))
(defun maximize-mac ()
  (interactive)
  (set-frame-position (selected-frame) 25 25)
  (set-frame-size (selected-frame) 197 53))
(defun maximize-linux ()
  (interactive)
  (set-frame-position (selected-frame) 20 20)
  (set-frame-size (selected-frame) 185 50))
(defun fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

(defun multiline-arg-list ()
  "take a long function list that hangs off the right side of the screen
and make it a multiline argument list.  So far, this works in PHP but probably
also works in c and c++"
  (interactive)
  (save-excursion
    (search-backward "(")  ;; find start of argument list
    (let ((start-pos (point)))
      (push-mark)
      (forward-sexp)
      (let ((end-pos (point)))
        (goto-char start-pos)
        (while (search-forward-regexp ", *\n*" end-pos t) ;; replace each comma with a comma + newline
          (replace-match ",\n"))                       ;; and take care of spaces
        (indent-region start-pos end-pos))))
  (c-indent-command))


(defun insert-character-to-column (insert-char column)
  (let ((c 0))
    (while (and (< (current-column) 80)
                (< c 80))
      (insert insert-char)
      (setq c (+ c 1)))))

(defun insert-hr (line-char)
  "Insert a commented horizontal bar or whatever
character you want out to column 80"
  (interactive "cLine Character: ")
  (save-excursion
    (c-indent-command)
    (insert "//")
    (insert-character-to-column line-char 80)))

(defun insert-break ()
  " Insert a box that looks like:
  //////////////////////////////////////////////////////////////////////////////
  //
  //////////////////////////////////////////////////////////////////////////////"
  (interactive)
  (c-indent-command)
  (back-to-indentation)
  (insert-character-to-column "/" 80)
  (insert "\n")
  (c-indent-command)
  (insert "// ")
  (insert "\n")
  (c-indent-command)
  (insert-character-to-column "/" 80)
  (previous-line))

;; Shamelessly stolen from S. Yegge's my-dot-emacs-file blog post
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR."
  (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn 	(copy-file filename newname 1)
              (delete-file filename)
              (set-visited-file-name newname)
              (set-buffer-modified-p nil)
              t))))

(defun trim-trailing-whitespace (str)
  (replace-regexp-in-string (rx (* (any " \t\n")) eos)
			    ""
			    str))

(defun get-github-org-and-repo ()
  "Take the output from git ls-remote --get-url which looks like
git@github.com:justnoise/emacs.d.git
and turn it into a list containing the org and repository
(justnoise emacs.d)"
  (let ((default-directory (magit-toplevel))
	(org-repo-string
	 (nth 1(split-string(trim-trailing-whitespace (shell-command-to-string
						       "git ls-remote --get-url"))
			    ":"))))
    (let* ((org-repo (split-string org-repo-string "/"))
	   (org (car org-repo))
	   (repo (replace-regexp-in-string ".git" "" (nth 1 org-repo))))
      (list org repo))))

(defun show-in-github (r1 r2)
  (require 'magit)
  (interactive "r")
  (save-excursion
    (multiple-value-setq (org-name repo-name) (get-github-org-and-repo))
    (let* ((fn (magit-file-relative-name (buffer-file-name)))
	   (branch-name (magit-get-current-branch))
	   (github-url (format "https://github.com/%s/%s/blob/%s/%s#L%s-L%s"
			       org-name
			       repo-name
			       branch-name
			       fn
			       (line-number-at-pos r1)
			       (line-number-at-pos r2))))
      (kill-new github-url)
      (message "git url: %s" github-url))))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun format-region-as-json (r1 r2)
  (interactive "r")
  (shell-command-on-region r1 r2 "python -m json.tool" nil 1))

(defun set-trace()
  (interactive)
  (open-previous-line 1)
  (cond ((equal major-mode 'ruby-mode) (insert "require 'pry'; binding.pry"))
	((equal major-mode 'python-mode) (insert "import pdb; pdb.set_trace()"))))


(defun kill-all-buffers()
  (interactive)
  (dolist (buf (buffer-list))
    (message (buffer-file-name buf))
    (if (or (and (buffer-file-name buf)
		 (not (or
		       (string-suffix-p "todo.txt" (buffer-file-name buf))
		       (string-suffix-p "todo.org" (buffer-file-name buf)))))
	    (string-prefix-p "*ag search" (buffer-name buf)))
	(kill-buffer buf))))

(defun verify-yaml()
  (interactive)
  (shell-command-on-region
   (point-min) (point-max)
   "/usr/local/bin/python -c 'import yaml,sys;yaml.safe_load(sys.stdin)'"))
