;; ;; yeah, I see why people scream "oh god my eyes!"...
;; (require 'paredit)
;; (require 'rainbow-parens)
;; (defun turn-on-paredit ()
;;   (paredit-mode t))
;; (dolist (x '(scheme emacs-lisp lisp clojure lisp-interaction))
;;   (add-hook
;;    (intern (concat (symbol-name x) "-mode-hook")) 'turn-on-paredit)
;;   (add-hook
;;    (intern (concat (symbol-name x) "-mode-hook")) 'rainbow-paren-mode))
