
;; Features:
;; * declare-func - copy the function definition for the function you're currently editing
;; * create-header-file.  When editing a .cpp file, this creates the correct .h file with
;;   include guards
;;
;;
;

(defun insert-copyright ()
  (interactive)
  (goto-char (point-min))
  (insert "//\n")
  (insert "//\n")
  (insert (format-time-string "//  Copyright (c) %Y\n"))
  (insert "//  Thomson Reuters\n")          
  (insert "//\n")
  (insert "//  $ID: "
          (buffer-name)
          ",v 1.0 "
          (format-time-string "%Y/%m/%d %H:%M:%S ")
          "bcox Exp $\n")
  (insert "//\n")
  (insert "//\n"))


(defun beginning-of-line-point ()
  (move-beginning-of-line nil)
  (point))
(defun end-of-line-point ()
  (move-end-of-line nil)
  (point))

(defun beginning-of-statement-point ()
  (c-beginning-of-statement-1)
  (point))
(defun end-of-statement-point ()
  (c-end-of-statement)
  (point))

(defun word-beginning-point ()
  (backward-word)
  (point))
(defun word-end-point ()
  (forward-word)
  (point))

(defun get-filename-from-pathname (path)
  "returns the filename name.ext of a complete path"
  (car (last (split-string path "/"))))

(defun get-filename-name (path)
  "Given a filename or a path return the filename minus the extension
does not work on full paths"
  (let ((filename (get-filename-from-pathname path)))
    (car (split-string filename "\\."))))

(defun get-filename-extension (path)
  "Given a filename (not a path) return the extension
does not work on full paths"
  (let ((filename (get-filename-from-pathname path)))
    (cadr (split-string filename "\\."))))

(defun change-filename-extension (filename new-extension)
  "changes the extension of the specified file to new-extension (a string)"
  (let ((name (get-filename-name filename)))
    ;;user might supply a ".ext" as the extension.  correct this for them
    (when (string= (substring new-extension 0 1) ".")
      (setq new-extension (substring new-extension 1)))
    (if (null name)
	(error "Error: could not get filename for change filename extnsion")
      (concat name "." new-extension))))

(defun get-header-name (filename)
  (change-filename-extension filename "h"))

(defun get-header-guard (filename)
  "Creates a header include guard of the form FILENAME_H__"
  (concat (upcase (get-filename-name filename))
	  "_H_"))

(defun create-header-file (&optional filename)
  "Creates a header file with include guards for the C++ source file"
  (interactive "bCreate header for file")
  (when (or (null filename)
	    (string= filename (buffer-name)))
      (setq filename (change-filename-extension (buffer-name) "h")))
;;   (when (file-exists-p filename)
;;       (error "File %s already esists" filename))
  (find-file filename)
  (let* ((header-guard (get-header-guard filename)))
    (goto-char (point-min))
    (insert (concat "#ifndef " header-guard "\n#define " header-guard "\n\n"))
    (goto-char (point-max))
    (insert (concat "\n#endif //" header-guard))))
         
;;          (boilerplate (concat "#ifndef " header-guard "\n#define " header-guard
;; 			      "\n\n\n\n#endif //" header-guard)))
;;     (insert boilerplate)))

;; (defun get-decl-class ()
;;   (let ((beg (line-beginning-point)))
;;     (move-end-of-line nil)
;;     (let ((class-end (search-backward "::" beg t)))
;;       ;; Now the point is either at the start of the line or at the end of the class name
;;       (if (null class-end)
;; 	  nul
;; 	(let ((word-end (point))
;; 	      (word-start (word-beginning-point)))
;;	  (buffer-substring word-start word-end))))))



;We're going to need to take template functions into account here as wall
(defun define-func ()
  "called from anywhere in the function body, define-func will
copy the function prototype, remove the class name and push it onto the kill ring
it then opens the header file so the user can paste the declaration into the header
Bugs: doesn't work with multiline function prototypes (eg template<typename...>)
      Error if the header file doesn't exist yet"
  (interactive)
  (save-excursion
    (c-end-of-defun)
    (c-beginning-of-defun)
    ;;we have to grab the end FIRST then the beginning of the statement
    ;;or else we move the point out of the current function
    (let ((decl-end (end-of-statement-point))
          (decl-start (beginning-of-statement-point)))
	  ;; pull out the function def, remove the classname and put it on the kill ring
      (kill-new (remove-classname (buffer-substring-no-properties decl-start decl-end)))
      (let ((header-name (get-header-name (buffer-name))))
        (when (not (file-exists-p header-name))
          ;;TODO: prompt user to create header file
          (error "header file doesn't exist"))
        (if (get-file-buffer header-name)
            (switch-to-buffer (get-file-buffer header-name))
          (find-file header-name))))))
;; key idea: "C-c d"


(defun remove-classname (declaration)
  "Removes the classname from a function definition eg:
bool RenamerDialog::getDirectoryEntries(QStringList &strListEntries)
becomes:
bool getDirectoryEntries(QStringList &strListEntries)
if classneame doesn't exist, return the declaration"
  (let* ((match-start (string-match " [_<>[:alnum:]]+::" declaration))
	 (match-end (string-match "::" declaration match-start)))
    (unless (or (null match-start) (null match-end))
	  (setq match-start (+ match-start 1))
	  (setq match-end (+ match-end 2))
	  (let ((a (substring declaration 0 match-start))
		(b (substring declaration match-end)))
	    (setq declaration (concat a b))))
      (concat declaration ";")))

;;get entire line
;;get class
;;if class:
;;find declaration of class
;;prompt user for public private or protected
;;find that in the class def
;;remove class:: part then copy to the correct section of the class
;;if not class:
;;open header file
;;if it doesn't exist prompt for creation
;;--find correct area for insertion??
;;insert

(defun insert-include (filename)
  (interactive "sHeader filename: ")
  (set-mark (point))
  (kill-new (concat "#include "filename))
  (goto-char (point-min)))
;;define idea: "C-c i"
