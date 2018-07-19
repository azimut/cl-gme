(asdf:defsystem #:cl-gme
  :description "gme"
  :author "azimut <azimut.github@protonmail.com>"
  :license "GPL-3.0"
  :serial t
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "cl-gme")))

(asdf:defsystem #:cl-gme/incudine
    :description "gme for incudine"
    :author "azimut"
    :license "GPL-3.0"
    :serial t
    :depends-on (#:cl-gme)
    :components ((:file "contrib/gmeincudine")))
