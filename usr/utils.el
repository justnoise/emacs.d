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


;; might want to change this to a bookmark?
(defun eetasks () 
  (interactive) 
  (find-file "/home/bcox/sandbox/scripts/bin/tasks.xml")
  (setq buffer-read-only t))

(defun create-diary ()
  (interactive)
  (let ((todays-date (format-time-string "%Y%m%d.txt")))
    (find-file (concat "/Users/bcox/diary/" todays-date))))
    
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(global-set-key (quote [f7]) 'switch-to-last-buffer)


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
(defun make-big ()
  (interactive)
  (set-frame-position (selected-frame) -1780 1)
  (set-frame-size (selected-frame) 250 75))

(defun make-small ()
  (interactive)
  (set-frame-position (selected-frame) 25 25)
  (set-frame-size (selected-frame) 100 50))
(defun maximize-mac ()
  (interactive)
  (set-frame-position (selected-frame) 25 25)
  (set-frame-size (selected-frame) 197 60))
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
