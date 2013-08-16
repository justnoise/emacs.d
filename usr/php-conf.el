(add-lib-path "php-mode")

(require 'php-mode)
(add-to-list 'auto-mode-alist
              '("\\.php[34]?\\'\\|\\.phtml\\|\\.class\\'" . php-mode))

(defun insert-dolla ()
  (interactive)
  (save-excursion
    (backward-sexp)
    (while (string= (char-to-string (char-before)) ">")
        (backward-sexp))
    (insert "$")))
(global-set-key (kbd "C-$") 'insert-dolla)
