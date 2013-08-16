(defun shortest-length (tasknames)
  (apply 'min (mapcar 'length tasknames)))

(defun string-index (i)
  "good ol elisp doesnt have closures but you can get close
with a lexical let.  Still not entirely sure how this works
OK, #' is read syntax for (function ...) where function is a 
special form that returns a function object without evaluating
it"
  (lexical-let ((i i))
    #'(lambda (x)
        (substring x i (1+ i)))))

(defun all-elements-equal (eq-fun elements)
  "returns t if all elements in the list elements are equal
equal ufnction is passed in as eq-fun"
  (let ((first-element (car elements))
        (all-equal t))
    (dolist (elem (cdr elements))
      (if (not (funcall eq-fun first-element elem))
          (setq all-equal nil)))
    all-equal))

(defun longest-common-substring (tasknames)
  (let ((min-length (apply 'min (mapcar 'length tasknames)))
        (common-substring "")
        (still-common t)
        (i 0))
    (while (and still-common (< i min-length))
      (let* ((strings-at-index (mapcar (string-index i) tasknames))
             (cur-char (car strings-at-index)))
        (if (not (all-elements-equal 'string= strings-at-index))
            (setq still-common nil)
          (setq common-substring (concat common-substring cur-char))))
      (setq i (1+ i)))
    common-substring))
        
(defun insert-header ()
  (insert "WHENEVER OSERROR EXIT FAILURE\n")
  (insert "WHENEVER SQLERROR EXIT FAILURE\n\n"))

(defun insert-task (taskname region)
  (insert (concat "insert into task_queue values (seq_task_queue_id.nextval, 'BACKOFFICE', 'WAITING', 0, to_date('&1', 'YYYYMMDD') - to_date('18991230', 'YYYYMMDD'),'" taskname "','I'," region ",sysdate,null,null,null,null,'Release rerun'," region ");\n")))

(defun sql-query (task-query-string)
  (insert (concat "select queue_id from task_queue where action_code = 'BACKOFFICE' and text_key like '" task-query-string "%' and numeric_key = to_date('&1', 'YYYYMMDD') - to_date('18991230', 'YYYYMMDD') and status <> 'COMPLETED';\n")))
  
(defun create-task-file (&rest tasknames)
  (with-temp-buffer
    (insert-header)
    (loop for taskname in tasknames
          do (insert-task taskname region))
    (insert "\ncommit;\n\n")
    (sql-query (longest-common-substring tasknames))
    (insert "\nquit\n")
    (write-file filename)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun create-shell-script (num-scripts)
  (with-temp-buffer
    (insert "#!/bin/bash\n\n")
    (insert "if [[ $# -lt 2 ]]; then\n")
    (insert "\techo \"Usage: task_queue.smart_holdings_rerun.sh <step=")
    (setq i 1)
    (while (<= i num-scripts)
      (setq str-i (prin1-to-string i))
      (insert str-i)
      (when (/= i num-scripts)
        (insert "|"))
      (setq i (+ i 1)))
    (insert "> <dataload date [yyyymmdd]>\";\n")
    (insert "exit 2;\n")
    (insert "fi\n\n")
    (insert "sqlplus starmine/smdev@starmine_dev @task_queue.smart_holdings_rerun.$1.sql $2\n")
    (write-file filename)))

;; (setq filename "task_queue.smart_holdings_rerun.sh")
;; (create-shell-script 14)

;; (setq region "84")

;; (setq filename "task_queue.smart_holdings_rerun.14.sql")
;; (create-task-file "smart_holdings_model,score,import,smart_holdings_model_string_av"
;;                   "smart_holdings_model,score,import,smart_holdings_model_score"
;;                   "smart_holdings_model,score,import,smart_holdings_model_long_av")

;; (setq filename "task_queue.smart_holdings_rerun.13.sql")
;; (create-task-file "smart_holdings_model,score,extract")

;; (setq filename "task_queue.smart_holdings_rerun.12.sql")
;; (create-task-file "smart_holdings_model,score,clean,smart_holdings_model_string_av"
;;                   "smart_holdings_model,score,clean,smart_holdings_model_score"
;;                   "smart_holdings_model,score,clean,smart_holdings_model_long_av")

;; (setq filename "task_queue.smart_holdings_rerun.11.sql")
;; (create-task-file "smart_holdings_model,intermediate,import")

;; (setq filename "task_queue.smart_holdings_rerun.10.sql")
;; (create-task-file "smart_holdings_model,intermediate,extract")

;; (setq filename "task_queue.smart_holdings_rerun.9.sql")
;; (create-task-file "smart_holdings_model,intermediate,clean")

;; (setq filename "task_queue.smart_holdings_rerun.8.sql")
;; (create-task-file "smart_holdings_model,factor_ranks,import")

;; (setq filename "task_queue.smart_holdings_rerun.7.sql")
;; (create-task-file "smart_holdings_model,factor_ranks,extract")

;; (setq filename "task_queue.smart_holdings_rerun.6.sql")
;; (create-task-file "smart_holdings_model,factor_ranks,clean")

;; (setq filename "task_queue.smart_holdings_rerun.5.sql")
;; (create-task-file "smart_holdings_model,factor_inputs,import")

;; (setq filename "task_queue.smart_holdings_rerun.4.sql")
;; (create-task-file "smart_holdings_model,factor_inputs,extract,603870,999999"
;;                   "smart_holdings_model,factor_inputs,extract,464955,602000"
;;                   "smart_holdings_model,factor_inputs,extract,356625,464954"
;;                   "smart_holdings_model,factor_inputs,extract,289606,356612"
;;                   "smart_holdings_model,factor_inputs,extract,272630,289492"
;;                   "smart_holdings_model,factor_inputs,extract,196708,272592"
;;                   "smart_holdings_model,factor_inputs,extract,44280,195676"
;;                   "smart_holdings_model,factor_inputs,extract,37538,44265"
;;                   "smart_holdings_model,factor_inputs,extract,29235,37533"
;;                   "smart_holdings_model,factor_inputs,extract,1,29226")

;; (setq filename "task_queue.smart_holdings_rerun.3.sql")
;; (create-task-file "smart_holdings_model,factor_inputs,clean")

;; (setq filename "task_queue.smart_holdings_rerun.2.sql")
;; (create-task-file "smart_holdings_model,security,import")

;; (setq filename "task_queue.smart_holdings_rerun.1.sql")
;; (create-task-file "smart_holdings_model,security,extract")
