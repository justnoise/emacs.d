(defvar last-prompt-file nil
  "Stores the last opened or created prompt file.")

(defun prompt-new ()
  "Create a new prompt file in ~/prompts/ with a structured template."
  (interactive)
  (let* ((dir (expand-file-name "prompts" (getenv "HOME")))
         (timestamp (format-time-string "%Y%m%d-%H%M%S"))
         (filename (concat "prompt-" timestamp ".md"))
         (filepath (expand-file-name filename dir)))
    ;; Ensure the directory exists
    (unless (file-exists-p dir)
      (make-directory dir t))
    ;; Store the last prompt file
    (setq last-prompt-file filepath)
    ;; Create and open the file with the template
    (find-file filepath)
    (insert "## **Objective**\n"
            "(Briefly describe what you're trying to accomplish. Include relevant details such as programming language, framework, and constraints.)\n\n"
            "## **Current Code or Setup**\n"
            "\n```language [filename.ext]  # (optional: specify filename)\n"
            "\n```\n")))

(defun prompt ()
  "Open the last created or viewed prompt file."
  (interactive)
  (if last-prompt-file
      (find-file last-prompt-file)
    (message "No prompt file has been opened yet.")))

(defun set-prompt (filepath)
  "Manually set the last prompt file to FILEPATH."
  (interactive "fSelect prompt file: ")
  (setq last-prompt-file filepath)
  (message "Last prompt set to: %s" filepath))

(defun prompt-expand-files ()
  "Replace #include statements in the current buffer with the contents of the specified files."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^#include[[:space:]]+\\(\/.+\\)$" nil t)
      (let* ((filepath (match-string 1))
             (ext (file-name-extension filepath))
             (content (if (file-exists-p filepath)
                          (with-temp-buffer
                            (insert-file-contents filepath)
                            (buffer-string))
                        (format "File not found: %s" filepath))))
        (replace-match (format "``` %s\n%s\n```" filepath content) t t)))))

(defun prompt-include-file ()
  "Insert an #include statement for the current file into the lastopened prompt buffer."
  (interactive)
  (if (and last-prompt-file (buffer-file-name))
      (let ((filepath (buffer-file-name)))
        (with-current-buffer (find-file-noselect last-prompt-file)
          (goto-char (point-max))
          (insert (format "\n#include %s\n" filepath))
          (message "Inserted #include statement for: %s" filepath))))
    (message "No prompt file set or current buffer has no file."))

(defun prompt-include-region (start end)
  "Insert the selected region into the last opened prompt buffer with file path information."
  (interactive "r")
  (if (and last-prompt-file (buffer-file-name))
      (let ((filepath (buffer-file-name))
            (content (buffer-substring-no-properties start end)))
        (with-current-buffer (find-file-noselect last-prompt-file)
          (goto-char (point-max))
          (insert (format "\n``` %s\n%s\n```\n" filepath content))
          (message "Inserted selected region from: %s" filepath)))
    (message "No prompt file set or current buffer has no file.")))
