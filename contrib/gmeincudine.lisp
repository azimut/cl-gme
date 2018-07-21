(in-package :cl-gme)

(pushnew (asdf:system-relative-pathname :cl-gme "contrib/")
         *foreign-library-directories*
         :test #'equal)

;; (cffi:define-foreign-library gme
;;   (:unix (:or "gmeincudine.so")))

(cffi:defcfun ("gmefile_to_buffer" gmefile-to-buffer) :void
  (buf :pointer)
  (gmefile :pointer)
  (frames :unsigned-long)
  (offset :unsigned-long))

(load-foreign-library '(:default "gmeincudine"))
