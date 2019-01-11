(uiop:define-package #:cl-gme
    (:use #:cl #:cffi)
  (:export #:with-file
           #:with-track
           #:track-count
           #:track-info
           #:voice-count
           #:voice-names))
