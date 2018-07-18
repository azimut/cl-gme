(asdf:defsystem #:cl-gme
  :description "gme"
  :author "azimut <azimut.github@protonmail.com>"
  :license "BSD-3"
  :serial t
  :depends-on (#:cffi)
  :components ((:file "package")
               (:file "cl-gme")))

(asdf:defsystem #:cl-gme/incudine
    :description "gme for incudine"
    :author "azimut"
    :license "BSD-3"
    :serial t
    :depends-on (#:cl-gme)
    :components ((:file "contrib/gmeincudine")))
