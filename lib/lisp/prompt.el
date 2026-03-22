(defvar last-prompt-file nil
  "Stores the last opened or created prompt file.")

(defun new-prompt-helper ()
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
    (find-file filepath)))

(defun new-prompt-role ()
  " seeing if this GPT suggested prompt helps. Might be better for focusing attention"
  (interactive)
  (new-prompt-helper)
  (insert
   "## 🧑‍💻 Role\n"
   "You are a senior backend engineer with deep experience in:\n"
   "- <insert relevant technologies here, e.g., grpc-js, Node.js, performance tuning>\n\n"
   "## 🧠 Context\n"
   "Briefly describe the system and what you're trying to do.\n"
   "For example:\n"
   "- Working on a Node.js gRPC client\n"
   "- Experiencing flaky behavior with retries\n\n"
   "## 🎯 Goal\n"
   "What do you want the model to help with?\n"
   "Examples:\n"
   "- Diagnose the cause of RST_STREAM errors\n"
   "- Refactor retry logic to improve reliability\n\n"
   "Show the model how to think or ask for steps or structured analysis (e.g. Think through this like you're debugging it step-by-step.\n"
   "Say what kind of answer you want\n\n"
   "## 🔍 Relevant Details\n"
   "Include anything that could help focus the model’s attention:\n"
   "- Retry strategy and error codes\n"
   "- Behavior of request object reuse\n"
   "- Metrics or logging available\n\n"
   "## 💻 Code\n"
   ))

(defun new-prompt ()
  "Create a new prompt file in ~/prompts/ with a structured template."
  (interactive)
  (new-prompt-helper)
  (insert "## **Background**\n\n"
	  "## **Objective**\n\n"
          "## **Current Code or Setup**\n"))

(defun new-prompt-detailed ()
  "Create a new prompt file in ~/prompts/ with a more detailed structured template."
  (interactive)
  (new-prompt-helper)
  (insert "You are a senior software engineer whose role is to provide clear, actionable code changes. For each edit required:\n\n"
	  "1. **Specify locations and changes:**\n"
	  "   - File path/name\n"
	  "   - Function/class being modified\n"
	  "   - The type of change (add/modify/remove)\n"
	  "2. **Show complete code for:**\n"
	  "   - Any modified functions (entire function)\n"
	  "   - New functions or methods\n"
	  "   - Changed class definitions\n"
	  "   - Modified configuration blocks\n"
	  "\nOnly show code units that actually change.\n\n"
	  "3. **Format all responses as:**\n"
	  "- File: path/filename.ext\n"
	  "- Change: Brief description of what's changing\n\n"
	  "4. **Use the following format for code blocks:**\n"
	  "``` filename.ext\n"
	  "Code goes here\n"
	  "```\n"))

(defun new-prompt-role ()
  (interactive)
  (new-prompt-helper)
  (insert "## Role\n"
	  "You are a senior backend engineer with deep experience in\n"
	  "<insert necessary technologies>\n\n"
	  "## Context\n"
	  "explain the problem\n\n"
	  "## Goal\n"
	  "Help me\n"
	  "<insert goal>\n\n"
	  "## Relevant Details\n"
	  "<Identify areas the model should supply attention to>\n"
	  "<add key facts before code>\n\n"
	  "## Code:\n"))

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

(defun prompt-include-helper (dirpath recursive)
  "Helper function to insert #include statements for files in DIRPATH into the prompt"
  (if last-prompt-file
      (let ((files (if recursive
		       (directory-files-recursively dirpath "^[^.].*")
		     (directory-files dirpath t "^[^.].*"))))
	(with-current-buffer (find-file-noselect last-prompt-file)
	  (goto-char (point-max))
	  (dolist (file files)
	    (when (file-regular-p file)
	      (insert (format "\n#include %s\n" file))))
	  (if recursive
	      (message "Inserted #include statements for files in: %s and its subdirectories" dirpath))
	  (message "Inserted #include statements for files in: %s" dirpath)))
    (message "No prompt file set.")))

(defun prompt-include-directory (dirpath)
  "Insert #include statements for all files in the specified directory into the last opened prompt buffer."
  (interactive "DSelect directory: ")
  (prompt-include-helper dirpath nil))

(defun prompt-include-directory-recursive (dirpath)
  "Insert #include statements for all files in the specified directory and its subdirectories into the last opened prompt buffer."
  (interactive "DSelect directory: ")
  (prompt-include-helper dirpath t))

(defun prompt-tokens ()
  "Count and display the approximate number of tokens in the current buffer."
  (interactive)
  (let* ((content (buffer-substring-no-properties (point-min) (point-max)))
	 (char-count (length content))
	 (token-count (ceiling (/ char-count 4.0))))
    (message "Token count: %d" token-count)))
