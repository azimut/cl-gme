(asdf:defsystem "cl-gme"
  :description "gme"
  :author "azimut <azimut.github@protonmail.com>"
  :license "BSD-3"
  :serial t
  :depends-on (
               #:cffi)
  :components ((:file "package")
               (:file "cl-gme")))
