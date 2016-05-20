;----------------------------------------
; IDO Mode for fast buffer switching is always ON
;----------------------------------------
(require 'ido)
(require 'flx-ido)

(ido-mode t)
(ido-everywhere t)
;;(flx-ido-mode 1)
(defun ido-settings ()
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil)
  (setq ido-auto-merge-delay-time 99999)
  (setq ido-max-directory-size 1000000))

(eval-after-load 'ido
  `(ido-settings))
(provide 'ido-settings)


;; look into flx-ido
;; https://github.com/lewang/flx
