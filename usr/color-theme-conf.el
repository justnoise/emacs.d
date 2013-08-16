(add-lib-path "custom-color-themes") 
(add-lib-path "color-theme-6.6.0")

(require 'color-theme)
(require 'zenburn)
(require 'color-theme-subdued)
(require 'color-theme-gruber-darker)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-zenburn)))
