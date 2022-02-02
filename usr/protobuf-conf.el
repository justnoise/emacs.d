(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(use-package protobuf-mode
  :ensure t
  :hook (protobuf-mode . (lambda () (c-add-style "my-style" my-protobuf-style t))))


