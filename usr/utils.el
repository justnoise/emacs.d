
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
	(setq dir (concat (getenv "HOME") "/" (substring dir 1))))
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

;; ; == buffer transpose/swap ==
;; (setq swapping-buffer nil)
;; (setq swapping-window nil)
;; (defun swap-buffers-in-windows ()
;;   "Swap buffers between two windows"
;;   (interactive)
;;   (if (and swapping-window
;;            swapping-buffer)
;;       (let ((this-buffer (current-buffer))
;;             (this-window (selected-window)))
;;         (if (and (window-live-p swapping-window)
;;                  (buffer-live-p swapping-buffer))
;;             (progn (switch-to-buffer swapping-buffer)
;;                    (select-window swapping-window)
;;                    (switch-to-buffer this-buffer)
;;                    (select-window this-window)
;;                    (message "Swapped buffers."))
;;           (message "Old buffer/window killed.  Aborting."))
;;         (setq swapping-buffer nil)
;;         (setq swapping-window nil))
;;     (progn
;;       (setq swapping-buffer (current-buffer))
;;       (setq swapping-window (selected-window))
;;       (message "Buffer and window marked for swapping."))))
;; (global-set-key "\C-cs" 'swap-buffers-in-windows)
(global-set-key "\C-cs" 'window-swap-states)

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

(defun is-apple-silicon ()
  (and
   (eq system-type 'darwin)
   (string= (string-trim (shell-command-to-string "uname -m")) "arm64")))

;Set the frame to open at the top of the screen and fill screen vertically
(defun maximize ()
  (interactive)
  (cond ((eq system-type 'darwin)
	 (if (is-apple-silicon)
	     (progn
	       (set-frame-position (selected-frame) 25 25)
	       (set-frame-size (selected-frame) 210 61))
	   (progn
	     (set-frame-position (selected-frame) 25 25)
	     (set-frame-size (selected-frame) 217 62))))
	((eq system-type 'gnu/linux)
	 (set-frame-position (selected-frame) 45 16)
	 (set-frame-size (selected-frame) 167 45))))

(defun make-big-work ()
  (interactive)
  (set-frame-position (selected-frame) -2550 2)
  (set-frame-size (selected-frame) 316 81))
(defun make-big-home ()
  (interactive)
  (set-frame-position (selected-frame) -2550 2)
  (set-frame-size (selected-frame) 316 81))
(defun make-big ()
  (interactive)
  (make-big-home))
;; (defun make-big-home ()
;;   (interactive)
;;   (set-frame-position (selected-frame) 1440 1)
;;   (set-frame-size (selected-frame) 250 75))

(defun make-small ()
  (interactive)
  (set-frame-position (selected-frame) 25 25)
  (set-frame-size (selected-frame) 80 40))

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

(defun column-number-at-pos (point)
  "Return column number at POINT."
  (save-excursion
    (goto-char point)
    (current-column)))

(defun show-in-github (r1 r2)
  (interactive "r")
  (require 'magit)
  (save-excursion
    (if (eq (column-number-at-pos r2) 0)
	(progn
	  (goto-char r2)
	  (backward-char)
	  (setq r2 (point))))
    (cl-multiple-value-setq (org-name repo-name) (get-github-org-and-repo))
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

(defun new-pull-request()
  (interactive)
  (require 'magit)
  (cl-multiple-value-setq (org-name repo-name) (get-github-org-and-repo))
  (let* ((branch-name (magit-get-current-branch))
	   (github-url (format "https://github.com/%s/%s/compare/%s"
			       org-name
			       repo-name
			       branch-name))
	   (cmd (concat "open -a \"/Applications/Firefox.app/\" " github-url)))
    (shell-command cmd)))


(defun open-github-repo ()
  (interactive)
  (require 'magit)
  (multiple-value-setq (org-name repo-name) (get-github-org-and-repo))
  (let* ((github-url (format "https://github.com/%s/%s"
			    org-name
			    repo-name))
	 (cmd (concat "open -a \"/Applications/Google Chrome.app/\" " github-url)))
    (shell-command cmd)))

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

(defun format-region-clickhouse (r1 r2)
  (interactive "r")
  (let ((fmt-fn (lambda ()
		  (let* ((quoted-sqlstr
			  (concat
			   "\""
			   (replace-regexp-in-string "\n" " " (buffer-substring r1 r2))
			   "\""))
			 (cmd (concat "clickhouse format --query=" quoted-sqlstr)))
		    (shell-command-to-string cmd)))))
    (replace-region-contents r1 r2 fmt-fn)))


(defun format-region-postgres ()
  "A function to invoke pgFormatter as an external program."
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max)))
        (pgfrm "/opt/homebrew/Cellar/pgformatter/5.3/bin/pg_format" ) )
    (shell-command-on-region b e pgfrm (current-buffer) 1)) )

(defun unformat-region-clickhouse (r1 r2)
  (interactive "r")
  (remove-newlines-region r1 r2))

(defun remove-newlines-region (r1 r2)
  (interactive "r")
  (replace-string "\n" " " nil r1 r2))


(defun set-trace()
  (interactive)
  (open-previous-line 1)
  (cond ((equal major-mode 'ruby-mode) (insert "require 'pry'; binding.pry"))
	((equal major-mode 'python-mode) (insert "import pdb; pdb.set_trace()"))))

(defun console-log()
  (interactive)
  (open-previous-line 1)
  (insert "console.log(\"\");")
  (backward-char 3))

(defun iset-trace()
  (interactive)
  (open-previous-line 1)
  (cond ((equal major-mode 'ruby-mode) (insert "require 'pry'; binding.pry"))
	((equal major-mode 'python-mode) (insert "import ipdb; ipdb.set_trace()"))))

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

(defun unset-goal-column()
  (interactive)
  (set-goal-column 1))

(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))
(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

(defvar repo-abbrevs
  '(("s" . "/Users/bcox/sprig")
    ("a" . "/Users/bcox/go/src/github.com/Altinity")
    ("c" . "/Users/bcox/dist/ClickHouse/src")
    ))
(defun switch-repo (repo-abbrev)
  (interactive "cRepo: (s) sprig (a) altinity (c) clickhouse")
  (let ((fn (cdr (assoc (char-to-string repo-abbrev) repo-abbrevs))))
    (find-file fn)))
(global-set-key "\C-cr" 'switch-repo)

(defun big-print ()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 160 :family "Inconsolata")))))
  )
(defun huge-print ()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 180 :family "Inconsolata")))))
  )
(defun medium-print ()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 140 :family "Inconsolata")))))
  )
(defun small-print ()
  (interactive)
  (custom-set-faces
   '(default ((t (:height 130 :family "Inconsolata")))))
  )

(defun kill-other-buffer ()
  (interactive)
  (other-window 1)
  (kill-buffer)
  (other-window 1))
(global-set-key "\C-xj" 'kill-other-buffer)
1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123

(defun search-files (string)
  (interactive "sSearch string: ")
  (interactive (ag/read-from-minibuffer "Search string"))
  (let ((notes-dir (format "%s/notes" (getenv "HOME")))
	(local-dev-dir (format "%s/local_dev" (getenv "HOME"))))
    (ag string notes-dir)
    (ag string local-dev-dir)))

(setq jsdebugger-buffer nil)
(defun bazel-debug-output-dir ()
  (string-trim
   (string-remove-prefix
    "bazel-bin: "
    (shell-command-to-string "/bin/bash -c 'cd /Users/bcox/sprig && bazel info --config=debug 2> /dev/null | grep -e \'^bazel-bin:\''"))))

(defun breakpoint-helper (debug-cmd)
  (let* ((line (format-mode-line "%l"))
	 (bazelfile (concat
		     (bazel-debug-output-dir)
		     "/services/api/api.sh.runfiles/"
		     (string-remove-prefix "/Users/bcox/" (buffer-file-name)))))
    (with-current-buffer jsdebugger-buffer
      (term-send-raw-string (format "%s('%s', %s)" debug-cmd bazelfile line)))))

(defun breakpoint ()
  (interactive)
  (breakpoint-helper "setBreakpoint"))

(defun clear-breakpoint ()
  (interactive)
  (breakpoint-helper "clearBreakpoint"))

;; iterm is a shell script that runs applescript to launch a terminal
(defun run-debugger ()
  (interactive)
  (start-process "iterm" "*iterm*" "/Users/bcox/bin/iterm" "/Users/bcox/bin/debugapi.sh")
  (ansi-term "/bin/zsh" "jsdebugger")
  ;; if we have an old buffer it'll create a new jsdebugger window so we will
  ;; track the most recent name of the buffer
  (setq jsdebugger-buffer (buffer-name))
  (term-send-raw-string "node inspect localhost:9229"))

;; also useful: bazel-test-at-point
(defun bazel-test-package ()
  (interactive)
  (require 'bazel)
  (let* ((root (bazel--workspace-root buffer-file-name))
	 (dirname (file-name-directory buffer-file-name))
	 (pkg-dotdotdot (concat "//" (bazel--package-name dirname root) "/...")))
    (message pkg-dotdotdot)
    (bazel--compile "test" pkg-dotdotdot)))
