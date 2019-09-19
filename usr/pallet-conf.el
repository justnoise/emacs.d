(require 'cask (substitute-in-file-name "$HOME/.cask/cask.el"))
(cask-initialize)
(require 'pallet)
(pallet-mode t)
