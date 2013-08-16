;----------------------------------------
; IDO Mode for fast buffer switching is always ON
;----------------------------------------
(require 'ido)
(ido-mode t)
(defun ido-settings ()
  (setq ido-enable-flex-matching t)
  (setq ido-auto-merge-delay-time 99999)
  (setq ido-max-directory-size 1000000))

(eval-after-load 'ido
  `(ido-settings))
(provide 'ido-settings)
